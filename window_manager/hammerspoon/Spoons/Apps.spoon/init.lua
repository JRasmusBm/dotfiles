local M = {}

hs.hotkey.bind({ "cmd" }, "return", function()
  hs.application.launchOrFocus "alacritty"
end)

hs.hotkey.bind({ "cmd" }, "b", function()
  hs.application.launchOrFocus "brave browser"
end)

hs.hotkey.bind({ "cmd" }, "s", function()
  hs.application.launchOrFocus "slack"
end)

return M
