local M = {}

local ctrl_apps = {
  [1] = "brave browser",
  [2] = "alacritty",
  [3] = "slack",
  [8] = "obs",
  [9] = "kdenlive",
  [0] = "spotify",
}

local cmd_apps = {
  e = "finder",
}

for key, app in pairs(ctrl_apps) do
  if app ~= nil then
    hs.hotkey.bind({ "ctrl" }, tostring(key), function()
      hs.application.launchOrFocus(app)
    end)

    hs.hotkey.bind({ "ctrl", "shift" }, tostring(key), function()
      hs.application.launch(app)
    end)
  end
end

for key, app in pairs(cmd_apps) do
  if app ~= nil then
    hs.hotkey.bind({ "cmd" }, tostring(key), function()
      hs.application.launchOrFocus(app)
    end)

    hs.hotkey.bind({ "cmd", "shift" }, tostring(key), function()
      hs.application.launch(app)
    end)
  end
end

return M
