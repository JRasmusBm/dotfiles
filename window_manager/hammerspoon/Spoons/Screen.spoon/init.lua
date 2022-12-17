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

return M
