local M = {}

local apps = {
  [1] = "brave browser",
  [2] = "alacritty",
  [3] = "slack",
  [8] = "obs",
  [9] = "kdenlive",
  [0] = "spotify",
}

for key, app in pairs(apps) do
  if app ~= nil then
    hs.hotkey.bind({ "ctrl" }, tostring(key), function()
      hs.application.launchOrFocus(app)
    end)

    hs.hotkey.bind({ "ctrl", "shift" }, tostring(key), function()
      hs.application.launch(app)
    end)
  end
end

return M
