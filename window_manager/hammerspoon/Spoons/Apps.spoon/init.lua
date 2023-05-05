local M = {}

-- BROWSER

hs.hotkey.bind({ "ctrl" }, "1", function()
  hs.application.launchOrFocus "brave browser"
end)

hs.hotkey.bind({ "cmd" }, "b", function()
  hs.application.launchOrFocus "brave browser"
end)

-- TERMINAL

hs.hotkey.bind({ "ctrl" }, "2", function()
  hs.application.launchOrFocus "alacritty"
end)

hs.hotkey.bind({ "cmd" }, "return", function()
  hs.application.launchOrFocus "alacritty"
end)

-- SLACK

hs.hotkey.bind({ "ctrl" }, "3", function()
  hs.application.launchOrFocus "slack"
end)

hs.hotkey.bind({ "cmd" }, "s", function()
  hs.application.launchOrFocus "slack"
end)

-- OS

hs.hotkey.bind({ "cmd" }, "e", function()
  hs.application.launchOrFocus "finder"
end)

return M
