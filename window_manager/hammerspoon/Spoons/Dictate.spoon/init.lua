-- Cmd+Shift+D starts recording; Esc submits (transcribes and pastes);
-- Cmd+Shift+D again aborts. Transcription runs locally with whisper.cpp,
-- its VAD drops silence, so a recording with no speech aborts too.
-- While recording, ffmpeg also cuts CHUNK_SECONDS chunks; each finished
-- chunk is transcribed into a live preview panel. The pasted text comes
-- from one pass over the whole recording: chunk cuts split words.
-- Voice: wakeword/listen.py (openWakeWord, local) runs while unmuted.
-- Saying "Skalman" acts like Cmd+Shift+D, "Kör hårt" like Esc (its
-- audio is cut off before transcribing), "Avbryt" aborts.
-- Cmd+Alt+Shift+D mutes it; it mutes itself during Zoom or Meet calls.
-- Hits go to WAKE_LOG. M.start/M.submit/M.cancel drive it from `hs -c`.
-- Models: install_dependencies/dictation.
local M = {}

local COPYQ = "/Applications/CopyQ.app/Contents/MacOS/CopyQ"
local FFMPEG = "/opt/homebrew/bin/ffmpeg"
local WHISPER = "/opt/homebrew/bin/whisper-cli"
local MODELS = os.getenv("HOME") .. "/.local/share/whisper/"
local MODEL = MODELS .. "ggml-large-v3-turbo-q5_0.bin"
local VAD_MODEL = MODELS .. "ggml-silero-v5.1.2.bin"
local DIR = (os.getenv("TMPDIR") or "/tmp/") .. "dictation/"
local WAV = DIR .. "full.wav"
local CUT_WAV = DIR .. "cut.wav"
-- A chunk takes ~0.9s, so 2s chunks keep up. Don't shrink Whisper's
-- audio window (-ac) to speed it up: chunks then repeat and garble.
local CHUNK_SECONDS = 2
local POLL_SECONDS = 0.25
local PREVIEW_CHARS = 400
local MAX_DICTATION_ITEMS = 2
-- CopyQ picks up the clipboard on its own schedule: retry the tag
-- until the dictated text shows up in its history.
local MARK_DELAY = 0.3
local MARK_ATTEMPTS = 20
local EVAL_TIMEOUT = 5

local WAKE_DIR = os.getenv("HOME") .. "/.local/share/wakeword/"
local WAKE_PYTHON = WAKE_DIR .. "venv/bin/python"
local WAKE_LOG = os.getenv("HOME") .. "/.local/state/dictation/wakeword.log"
local WAKE = {
  start = { model = "skalman", threshold = 0.8 },
  submit = { model = "kor_hart", threshold = 0.8 },
  cancel = { model = "avbryt", threshold = 0.8 },
}
-- The submit word plus detection lag, cut from the recording's end.
local SUBMIT_CUT_SECONDS = 1.2
local WAV_BYTES_PER_SECOND = 32000
local CALL_POLL_SECONDS = 5
local RESTART_SECONDS = 5
local MEET_TITLE = "^Meet %- "
local BROWSERS = {
  "Google Chrome", "Brave Browser", "Arc", "Safari", "Firefox",
}

local function copyqEval(script, callback, ...)
  local timer
  local task = hs.task.new(COPYQ, function(_, stdout)
    timer:stop()
    if callback then
      callback(stdout)
    end
  end, { "eval", "--", script, ... })
  timer = hs.timer.doAfter(EVAL_TIMEOUT, function()
    if task:isRunning() then
      task:terminate()
      hs.alert.show("CopyQ not responding")
    end
  end)
  task:start()
end

local function cleanupDictationHistory()
  local script = string.format([[
var maxToKeep = %d;
var dictationRows = [];
for (var i = 0; i < count(); i++) {
  var mimes = str(read("?", i));
  if (mimes.indexOf("application/x-dictation") !== -1) {
    dictationRows.push(i);
  }
}
if (dictationRows.length > maxToKeep) {
  var toRemove = dictationRows.slice(maxToKeep);
  toRemove.reverse();
  for (var j = 0; j < toRemove.length; j++) {
    remove(toRemove[j]);
  }
}
]], MAX_DICTATION_ITEMS)

  copyqEval(script)
end

-- Tags the row holding the dictated text, not row 0: CopyQ may not
-- have added it yet, and row 0 is then something the user copied.
local MARK_SCRIPT = [[
var text = str(arguments[1]);
for (var i = 0; i < Math.min(count(), 10); i++) {
  if (str(read(i)) === text) {
    change(i, "application/x-dictation", "1");
    print("marked");
    break;
  }
}
]]

local function markAsDictation(text, attempt)
  attempt = attempt or 1
  copyqEval(MARK_SCRIPT, function(stdout)
    if stdout == "marked" then
      cleanupDictationHistory()
    elseif attempt < MARK_ATTEMPTS then
      hs.timer.doAfter(MARK_DELAY, function()
        markAsDictation(text, attempt + 1)
      end)
    end
  end, text)
end

local function trim(s)
  return ((s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

-- Greedy decoding (-bs 1 -bo 1): beam search costs ~0.5s per call.
local function whisper(file, prompt, callback)
  local args = {
    "-m", MODEL, "--vad", "-vm", VAD_MODEL, "-bs", "1", "-bo", "1",
    "-l", "en", "-nt", "-np", "-f", file,
  }
  if prompt ~= "" then
    hs.fnutils.concat(args, { "--prompt", prompt })
  end
  local task = hs.task.new(WHISPER, function(code, out)
    callback(code, trim(out))
  end, args)
  task:start()
  return task
end

-- Preview panel

local panel

local function showPanel(status, text)
  if not panel then
    local frame = hs.screen.mainScreen():frame()
    local w, h = math.min(760, frame.w - 40), 150
    panel = hs.canvas.new({
      x = frame.x + (frame.w - w) / 2,
      y = frame.y + frame.h - h - 40,
      w = w,
      h = h,
    })
    panel:level(hs.canvas.windowLevels.overlay)
    panel:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)
    panel[1] = {
      type = "rectangle",
      fillColor = { white = 0.1, alpha = 0.9 },
      roundedRectRadii = { xRadius = 12, yRadius = 12 },
    }
    panel[2] = {
      type = "text",
      frame = { x = 16, y = 12, w = w - 32, h = 24 },
      textSize = 15,
      textColor = { white = 0.7 },
    }
    panel[3] = {
      type = "text",
      frame = { x = 16, y = 40, w = w - 32, h = h - 52 },
      textSize = 17,
      textColor = { white = 1 },
    }
    panel:show()
  end
  if #text > PREVIEW_CHARS then
    text = "…" .. text:sub(-PREVIEW_CHARS)
  end
  panel[2].text = status
  panel[3].text = text
end

local function hidePanel()
  if panel then
    panel:delete()
    panel = nil
  end
end

-- Recording

-- state: nil (idle), "recording" or "transcribing"
local state, recorder, finalTask, chunkTask, poller
local preview, nextChunk, voiceSubmit
local escape
local RECORDING = "🎙 Recording…  Esc submits, ⌘⇧D aborts"

local function chunkPath(i)
  return string.format("%sc%04d.wav", DIR, i)
end

local function clearDir()
  hs.execute(string.format("rm -rf '%s' && mkdir -p '%s'", DIR, DIR))
end

local function stopTask(task)
  if task and task:isRunning() then
    task:terminate()
  end
end

local function reset()
  state = nil
  voiceSubmit = false
  stopTask(recorder)
  stopTask(finalTask)
  stopTask(chunkTask)
  if poller then
    poller:stop()
  end
  recorder, finalTask, chunkTask, poller = nil, nil, nil, nil
  escape:disable()
  hidePanel()
  clearDir()
end

local function paste(text)
  hs.pasteboard.setContents(text)
  hs.eventtap.keyStroke({ "cmd" }, "v")
  hs.timer.doAfter(MARK_DELAY, function()
    markAsDictation(text)
  end)
end

-- A chunk is finished once ffmpeg has started the next one.
local function pollChunks()
  if state ~= "recording" or chunkTask then
    return
  end
  if not hs.fs.attributes(chunkPath(nextChunk + 1)) then
    return
  end
  local file = chunkPath(nextChunk)
  nextChunk = nextChunk + 1
  chunkTask = whisper(file, preview:sub(-200), function(code, text)
    chunkTask = nil
    if state ~= "recording" then
      return
    end
    if code == 0 and text ~= "" then
      preview = trim(preview .. " " .. text)
      showPanel(RECORDING, preview)
    end
    pollChunks()
  end)
end

local function transcribe(file)
  finalTask = whisper(file, "", function(code, text)
    if state ~= "transcribing" then
      return
    end
    reset()
    if code ~= 0 then
      hs.alert.show("Dictation failed")
    elseif text == "" then
      hs.alert.show("Nothing recorded")
    else
      paste(text)
    end
  end)
end

-- Whisper's -d counts audio after VAD drops silence, so the submit
-- word is cut from the wav itself.
local function cutSubmitWord()
  local size = hs.fs.attributes(WAV, "size") or 0
  local seconds = size / WAV_BYTES_PER_SECOND - SUBMIT_CUT_SECONDS
  if seconds <= 0 then
    reset()
    hs.alert.show("Nothing recorded")
    return
  end
  finalTask = hs.task.new(FFMPEG, function(code)
    if state ~= "transcribing" then
      return
    end
    if code ~= 0 then
      reset()
      hs.alert.show("Dictation failed")
      return
    end
    transcribe(CUT_WAV)
  end, {
    "-hide_banner", "-loglevel", "error", "-y", "-i", WAV,
    "-t", string.format("%.2f", seconds), "-c", "copy", CUT_WAV,
  })
  finalTask:start()
end

local function submit()
  state = "transcribing"
  escape:disable()
  poller:stop()
  stopTask(chunkTask)
  showPanel("Transcribing…  ⌘⇧D aborts", preview)
  if voiceSubmit then
    cutSubmitWord()
  else
    transcribe(WAV)
  end
end

local function start()
  clearDir()
  preview, nextChunk = "", 0
  local fmt = { "-ac", "1", "-ar", "16000" }
  local args = {
    "-hide_banner", "-loglevel", "error", "-y",
    "-f", "avfoundation", "-i", ":default",
  }
  hs.fnutils.concat(args, fmt)
  table.insert(args, WAV)
  hs.fnutils.concat(args, fmt)
  hs.fnutils.concat(args, {
    "-f", "segment", "-segment_time", tostring(CHUNK_SECONDS),
    DIR .. "c%04d.wav",
  })
  recorder = hs.task.new(FFMPEG, function()
    if state == "recording" then
      submit()
    end
  end, args)
  if not recorder:start() then
    hs.alert.show("Dictation failed")
    return
  end
  state = "recording"
  hs.sound.getByName("Tink"):play()
  escape:enable()
  poller = hs.timer.doEvery(POLL_SECONDS, pollChunks)
  showPanel(RECORDING, "")
end

local function abort()
  reset()
  hs.alert.show("Dictation aborted")
end

-- ffmpeg finalises the wav on SIGTERM; its exit callback submits.
local function stopRecording()
  if state == "recording" then
    recorder:terminate()
  end
end

escape = hs.hotkey.new({}, "escape", stopRecording)

hs.hotkey.bind({ "cmd", "shift" }, "d", function()
  if state then
    abort()
  else
    start()
  end
end)

-- Each returns whether it acted: a phrase only counts in its state.
function M.start()
  if state then
    return false
  end
  start()
  return true
end

function M.submit()
  if state ~= "recording" then
    return false
  end
  voiceSubmit = true
  stopRecording()
  return true
end

function M.cancel()
  if not state then
    return false
  end
  abort()
  return true
end

-- Voice trigger

local listener, restartTimer
local muted, inCall = false, false

local function log(line)
  local f = io.open(WAKE_LOG, "a")
  if f then
    f:write(os.date("%Y-%m-%dT%H:%M:%S "), line, "\n")
    f:close()
  end
end

local function onHit(name, score)
  local was = state or "idle"
  local acted = M[name]()
  log(string.format("%s %s %s %s", name, score, was,
    acted and "acted" or "ignored"))
end

local startListener

local function stopListener()
  if restartTimer then
    restartTimer:stop()
    restartTimer = nil
  end
  if listener then
    local task = listener
    listener = nil
    task:terminate()
    log("listener off")
  end
end

local function wanted()
  return not muted and not inCall
end

startListener = function()
  if listener or not wanted() then
    return
  end
  if not hs.fs.attributes(WAKE_PYTHON) then
    return
  end
  local args = { hs.spoons.resourcePath("wakeword/listen.py") }
  for name, w in pairs(WAKE) do
    local model =
      hs.spoons.resourcePath("wakeword/models/" .. w.model .. ".onnx")
    if not hs.fs.attributes(model) then
      return
    end
    table.insert(args, string.format("%s=%s:%s", name, model, w.threshold))
  end
  local task
  task = hs.task.new(WAKE_PYTHON, function(code, _, err)
    if listener ~= task then
      return
    end
    listener = nil
    log(string.format("listener exited %d: %s", code, trim(err):sub(-200)))
    restartTimer = hs.timer.doAfter(RESTART_SECONDS, startListener)
  end, function(_, stdout)
    for name, score in (stdout or ""):gmatch("(%a+) ([%d.]+)") do
      if WAKE[name] then
        onHit(name, score)
      end
    end
    return true
  end, args)
  if task:start() then
    listener = task
    log("listener on")
  end
end

local function refresh()
  if wanted() then
    startListener()
  else
    stopListener()
  end
end

local function callRunning()
  local _, zoom = hs.execute("pgrep -xq CptHost")
  if zoom then
    return true
  end
  for _, name in ipairs(BROWSERS) do
    local app = hs.application.get(name)
    for _, win in ipairs(app and app:allWindows() or {}) do
      if (win:title() or ""):match(MEET_TITLE) then
        return true
      end
    end
  end
  return false
end

local function checkCall()
  local now = callRunning()
  if now ~= inCall then
    inCall = now
    log(inCall and "call: muted" or "call ended")
    refresh()
  end
end

hs.hotkey.bind({ "cmd", "alt", "shift" }, "d", function()
  muted = not muted
  log(muted and "muted" or "unmuted")
  hs.alert.show(muted and "Voice trigger muted" or "Voice trigger on")
  refresh()
end)

hs.execute(string.format("mkdir -p '%s'", WAKE_LOG:match("(.*)/")))
M.callTimer = hs.timer.doEvery(CALL_POLL_SECONDS, checkCall)
checkCall()
refresh()

return M
