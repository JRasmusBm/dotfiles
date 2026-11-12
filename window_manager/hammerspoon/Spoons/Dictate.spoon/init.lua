-- Cmd+Shift+D starts recording; Esc submits (transcribes and pastes);
-- Cmd+Shift+D again aborts. Transcription runs locally with whisper.cpp,
-- its VAD drops silence, so a recording with no speech aborts too.
-- While recording, ffmpeg also cuts CHUNK_SECONDS chunks; each finished
-- chunk is transcribed into a live preview panel. The pasted text comes
-- from one pass over the whole recording: chunk cuts split words.
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
local CHUNK_SECONDS = 2
-- Whisper encodes a fixed 30s window (1500 frames); a chunk needs ~100,
-- so a smaller window halves its time (~0.5s on an M-series GPU).
local CHUNK_AUDIO_CTX = "256"
local POLL_SECONDS = 0.25
local PREVIEW_CHARS = 400
local MAX_DICTATION_ITEMS = 2
local MARK_DELAY = 0.3
local EVAL_TIMEOUT = 5

local function copyqEval(script, callback)
  local timer
  local task = hs.task.new(COPYQ, function()
    timer:stop()
    if callback then
      callback()
    end
  end, { "eval", script })
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

local function markAsDictation()
  local script = [[
change(0, "application/x-dictation", "1");
]]
  copyqEval(script, cleanupDictationHistory)
end

local function trim(s)
  return ((s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

-- Greedy decoding (-bs 1 -bo 1): beam search costs ~0.5s per call.
local function whisper(file, prompt, callback, audioCtx)
  local args = {
    "-m", MODEL, "--vad", "-vm", VAD_MODEL, "-bs", "1", "-bo", "1",
    "-l", "en", "-nt", "-np", "-f", file,
  }
  if audioCtx then
    hs.fnutils.concat(args, { "-ac", audioCtx })
  end
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
local preview, nextChunk
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
  hs.timer.doAfter(MARK_DELAY, markAsDictation)
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
  end, CHUNK_AUDIO_CTX)
end

local function submit()
  state = "transcribing"
  escape:disable()
  poller:stop()
  stopTask(chunkTask)
  showPanel("Transcribing…  ⌘⇧D aborts", preview)
  finalTask = whisper(WAV, "", function(code, text)
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
  escape:enable()
  poller = hs.timer.doEvery(POLL_SECONDS, pollChunks)
  showPanel(RECORDING, "")
end

local function abort()
  reset()
  hs.alert.show("Dictation aborted")
end

-- ffmpeg finalises the wav on SIGTERM; its exit callback submits.
escape = hs.hotkey.new({}, "escape", function()
  if state == "recording" then
    recorder:terminate()
  end
end)

hs.hotkey.bind({ "cmd", "shift" }, "d", function()
  if state then
    abort()
  else
    start()
  end
end)

return M
