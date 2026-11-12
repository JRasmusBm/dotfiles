-- Cmd+Shift+D starts recording; Esc submits (transcribes and pastes);
-- Cmd+Shift+D again aborts. Transcription runs locally with whisper.cpp,
-- its VAD drops silence, so a recording with no speech aborts too.
-- Models: install_dependencies/dictation.
local M = {}

local COPYQ = "/Applications/CopyQ.app/Contents/MacOS/CopyQ"
local FFMPEG = "/opt/homebrew/bin/ffmpeg"
local WHISPER = "/opt/homebrew/bin/whisper-cli"
local MODELS = os.getenv("HOME") .. "/.local/share/whisper/"
local MODEL = MODELS .. "ggml-large-v3-turbo-q5_0.bin"
local VAD_MODEL = MODELS .. "ggml-silero-v5.1.2.bin"
local WAV = (os.getenv("TMPDIR") or "/tmp/") .. "dictation.wav"
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

-- state: nil (idle), "recording" or "transcribing"
local state, recorder, transcriber, banner
local escape

local function showBanner(text)
  if banner then
    hs.alert.closeSpecific(banner)
  end
  banner = text and hs.alert.show(text, true) or nil
end

local function reset()
  state, recorder, transcriber = nil, nil, nil
  escape:disable()
  showBanner(nil)
  os.remove(WAV)
end

local function paste(text)
  hs.pasteboard.setContents(text)
  hs.eventtap.keyStroke({ "cmd" }, "v")
  hs.timer.doAfter(MARK_DELAY, markAsDictation)
end

local function transcribe()
  state = "transcribing"
  escape:disable()
  showBanner("Transcribing…  ⌘⇧D aborts")
  transcriber = hs.task.new(WHISPER, function(code, out)
    if state ~= "transcribing" then
      return
    end
    reset()
    local text = (out or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if code ~= 0 then
      hs.alert.show("Dictation failed")
    elseif text == "" then
      hs.alert.show("Nothing recorded")
    else
      paste(text)
    end
  end, {
    "-m", MODEL, "--vad", "-vm", VAD_MODEL,
    "-l", "en", "-nt", "-np", "-f", WAV,
  })
  transcriber:start()
end

local function start()
  os.remove(WAV)
  recorder = hs.task.new(FFMPEG, function()
    if state == "recording" then
      transcribe()
    end
  end, {
    "-hide_banner", "-loglevel", "error", "-y",
    "-f", "avfoundation", "-i", ":default",
    "-ac", "1", "-ar", "16000", WAV,
  })
  if not recorder:start() then
    hs.alert.show("Dictation failed")
    return
  end
  state = "recording"
  escape:enable()
  showBanner("🎙 Recording…  Esc submits, ⌘⇧D aborts")
end

local function abort()
  local task = recorder or transcriber
  state = nil
  if task and task:isRunning() then
    task:terminate()
  end
  reset()
  hs.alert.show("Dictation aborted")
end

-- ffmpeg finalises the wav on SIGTERM; its exit callback transcribes.
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
