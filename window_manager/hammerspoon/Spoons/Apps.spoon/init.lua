local M = {}

local ctrl_apps = {
  [1] = "brave browser",
  [2] = "alacritty",
  [3] = "slack",
  [4] = "cypress",
  [6] = "gimp",
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

local bindAlt = function(key)
  hs.hotkey.bind({ "alt" }, tostring(key), function()
    hs.eventtap.keyStroke({ "alt" }, tostring(key), 0, hs.application.find "alacritty")
    hs.application.launchOrFocus "alacritty"
  end)
end

for i = 0, 9, 1 do
  bindAlt(i)
end
bindAlt("t")
bindAlt("p")

return M
