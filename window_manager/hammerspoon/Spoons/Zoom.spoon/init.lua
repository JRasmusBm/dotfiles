local M = {}

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

return M
