local M = {}

local COPYQ = "/Applications/CopyQ.app/Contents/MacOS/CopyQ"
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

hs.hotkey.bind({ "cmd", "shift" }, "d", function()
  hs.task
    .new("/usr/bin/shortcuts", function(exitCode)
      if exitCode == 0 then
        hs.eventtap.keyStroke({ "cmd" }, "v")
        hs.timer.doAfter(MARK_DELAY, markAsDictation)
      else
        hs.alert.show("Dictation failed")
      end
    end, { "run", "Dictate to Clipboard" })
    :start()
end)

return M
