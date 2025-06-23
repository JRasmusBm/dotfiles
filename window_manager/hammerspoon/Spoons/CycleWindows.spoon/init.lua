local M = {}

local cycleWindows = function(dx)
  local currentWindow = hs.window.focusedWindow()
  local currentApp = currentWindow:application()

  local windows = hs.fnutils.filter(currentApp:allWindows(), function(window)
    return window:isStandard()
  end)

  table.sort(windows, function(a, b)
    return a:id() < b:id()
  end)

  local currentWindowIndex = hs.fnutils.indexOf(windows, currentWindow)

  local nextWindowIndex = ((currentWindowIndex - 1 + dx) % #windows) + 1
  local nextWindow = windows[nextWindowIndex]

  nextWindow:focus()
end

hs.hotkey.bind({ "ctrl" }, "=", function()
  cycleWindows(1)
end)
hs.hotkey.bind({ "ctrl" }, "`", function()
  cycleWindows(1)
end)

hs.hotkey.bind({ "ctrl", "shift" }, "=", function()
  cycleWindows(-1)
end)
hs.hotkey.bind({ "ctrl", "shift" }, "`", function()
  cycleWindows(-1)
end)

return M
