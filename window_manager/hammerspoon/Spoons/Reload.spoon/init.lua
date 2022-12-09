local M = {}

hs.hotkey.bind({"cmd", "shift"}, "R", function()
  hs.reload()
  hs.notify.new({title="Hammerspoon", informativeText="Configuration reloaded!"}):send()
end)

return M
