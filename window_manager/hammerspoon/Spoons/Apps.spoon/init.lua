local M = {}

local apps = {
  [1] = "brave_browser",
  [2] = "alacritty",
  [3] = "slack",
  [8] = "obs",
  [9] = "kdelive",
}

-- for key, app in pairs(apps) do
--   if app ~= nil then
--     hs.hotkey.bind({ "ctrl" }, key, function()
--       hs.application.launchOrFocus(app)
--     end)
--   end
-- end

-- BROWSER

hs.hotkey.bind({ "ctrl" }, "1", function()
  hs.application.launchOrFocus "brave browser"
end)

-- TERMINAL

hs.hotkey.bind({ "ctrl" }, "2", function()
  hs.application.launchOrFocus "alacritty"
end)

-- SLACK

hs.hotkey.bind({ "ctrl" }, "3", function()
  hs.application.launchOrFocus "slack"
end)

-- OBS

hs.hotkey.bind({ "ctrl" }, "8", function()
  hs.application.launchOrFocus "obs"
end)

-- KDENLIVE

hs.hotkey.bind({ "ctrl" }, "9", function()
  hs.application.launchOrFocus "kdenlive"
end)

-- OS

hs.hotkey.bind({ "cmd" }, "e", function()
  hs.application.launchOrFocus "finder"
end)

return M
