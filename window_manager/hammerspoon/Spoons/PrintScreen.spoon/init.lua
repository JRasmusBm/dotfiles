local M = {}

hs.hotkey.bind({ "shift" }, "F13", function()
  hs.application.launchOrFocus "screenshot"
end)

return M
