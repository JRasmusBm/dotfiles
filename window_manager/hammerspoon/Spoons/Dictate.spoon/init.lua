local M = {}

local COPYQ = "/Applications/CopyQ.app/Contents/MacOS/CopyQ"
local MAX_DICTATION_ITEMS = 2
local MARK_DELAY = 0.3

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

  hs.task.new(COPYQ, nil, { "eval", script }):start()
end

local function markAsDictation()
  local script = [[
change(0, "application/x-dictation", "1");
]]
  hs.task.new(COPYQ, function()
    cleanupDictationHistory()
  end, { "eval", script }):start()
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
