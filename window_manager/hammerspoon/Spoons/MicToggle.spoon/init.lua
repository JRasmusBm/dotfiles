local M = {}
local muted = false
local savedMic = nil

local BLACKHOLE = "BlackHole 2ch"
local PREFERRED_MIC = "samson"
local FALLBACK_MIC = "MacBook Pro Microphone"
local IGNORED_INPUTS = { "wh-xb910n" }

local function findDevice(pattern)
  for _, dev in ipairs(hs.audiodevice.allInputDevices()) do
    if dev:name():lower():find(pattern:lower()) then
      return dev
    end
  end
  return nil
end

local function isIgnored(dev)
  if not dev then return false end
  local name = dev:name():lower()
  for _, pattern in ipairs(IGNORED_INPUTS) do
    if name:find(pattern:lower()) then
      return true
    end
  end
  return false
end

local function preferredMic()
  return findDevice(PREFERRED_MIC)
    or findDevice(FALLBACK_MIC)
    or hs.audiodevice.defaultInputDevice()
end

local function setDefaultInput(dev)
  if dev then dev:setDefaultInputDevice() end
end

local function correctInput()
  local current = hs.audiodevice.defaultInputDevice()
  if not current then return end

  if muted then
    -- Stay on BlackHole, but update savedMic
    local pref = preferredMic()
    if pref and not isIgnored(pref) then
      savedMic = pref
    end
    return
  end

  -- Correct away from ignored devices
  local target = preferredMic()
  if target and current:name() ~= target:name() then
    setDefaultInput(target)
    hs.alert.show(target:name(), {
      atScreenEdge = 2,
    }, hs.screen.mainScreen(), 0.5)
  end
end

local function onAudioDeviceChange(event)
  if event == "dev#" or event == "dIn " then
    correctInput()
  end
end

hs.audiodevice.watcher.setCallback(onAudioDeviceChange)
hs.audiodevice.watcher.start()
correctInput()

-- Mute toggle: switch input to BlackHole
hs.hotkey.bind({ "cmd", "shift" }, "m", function()
  local blackhole = findDevice(BLACKHOLE)
  if not blackhole then
    hs.alert.show("BlackHole not found", {
      atScreenEdge = 2,
    }, hs.screen.mainScreen(), 1)
    return
  end

  muted = not muted

  if muted then
    savedMic = hs.audiodevice.defaultInputDevice()
    setDefaultInput(blackhole)
  else
    setDefaultInput(savedMic or preferredMic())
    savedMic = nil
  end

  local text = muted and "Muted" or "Unmuted"
  hs.alert.show(text, {
    atScreenEdge = 2,
  }, hs.screen.mainScreen(), 0.5)
end)

return M
