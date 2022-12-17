local M = {}

hs.hotkey.bind({ "cmd" }, "right", function()
  local w = hs.window.focusedWindow()
  if w == nil then
    hs.notify
      .new({ title = "Hammerspoon", informativeText = "No window was focused" })
      :send()
    return
  end

  w:moveOneScreenEast()
end)

hs.hotkey.bind({ "cmd" }, "left", function()
  local w = hs.window.focusedWindow()

  if w == nil then
    hs.notify
      .new({ title = "Hammerspoon", informativeText = "No window was focused" })
      :send()
    return
  end

  w:moveOneScreenWest()
end)

hs.hotkey.bind({ "cmd", "shift" }, "z", function()
  local w = hs.window.focusedWindow()

  if w == nil then
    hs.notify
      .new({ title = "Hammerspoon", informativeText = "No window was focused" })
      :send()
    return
  end

  w:toggleZoom()
end)

local cycleWindows = function(dx)
  local currentWindow = hs.window.focusedWindow()
  local currentApp = currentWindow:application()
  local appname = currentApp:name()

  local windows = {}
  for i, app in ipairs { hs.application.find(appname) } do
    for i, window in ipairs(app:allWindows()) do
      table.insert(windows, window)
    end
  end

  local currentWindowIndex = 0
  for i, window in ipairs(windows) do
    currentWindowIndex = i
    if currentWindow:id() == window:id() then
      break
    end
  end

  local nextWindowIndex = ((currentWindowIndex - 1 + dx) % #windows) + 1
  local nextWindow = windows[nextWindowIndex]

  nextWindow:focus()
end

hs.hotkey.bind({ "cmd" }, "=", function()
  cycleWindows(1)
end)

hs.hotkey.bind({ "cmd", "shift" }, "=", function()
  cycleWindows(-1)
end)

return M
