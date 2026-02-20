local M = {}

hs.hotkey.bind({ "cmd", "shift" }, "m", function()
  local mic = hs.audiodevice.defaultInputDevice()
  if not mic then return end

  local muted = not mic:muted()
  for _, dev in ipairs(hs.audiodevice.allInputDevices()) do
    dev:setMuted(muted)
    dev:setInputMuted(muted)
  end

  local text = muted and "Muted" or "Unmuted"
  hs.alert.show(text, {
    atScreenEdge = 2,
  }, hs.screen.mainScreen(), 0.5)
end)

return M
