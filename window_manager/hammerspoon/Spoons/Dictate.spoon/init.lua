local M = {}

hs.hotkey.bind({ "cmd", "shift" }, "d", function()
  hs.task
    .new("/usr/bin/shortcuts", function(exitCode)
      if exitCode == 0 then
        hs.eventtap.keyStroke({ "cmd" }, "v")
      else
        hs.alert.show("Dictation failed")
      end
    end, { "run", "Dictate to Clipboard" })
    :start()
end)

return M
