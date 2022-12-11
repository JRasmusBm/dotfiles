-- docs
-- https://github.com/asmagill/hs._asm.spaces

local spaces = require "hs.spaces"

local M = {}

M.state = {
  spaces = {},
}

local getSpace = function(n)
  for _, space in pairs(M.state.spaces) do
    if space.nid == n then
      return space
    end
  end

  return nil
end

local createNewSpace = function(n)
  spaces.addSpaceToScreen(n)
  local space

  for key, s in pairs(spaces.allSpaces()) do
    if M.state.spaces[key] == nil then
      s.nid = n
      space = s
    end
  end

  return space
end

local refreshState = function()
  for i = 1, 10, 1 do
    if getSpace(i) == nil then
      createNewSpace(i)
    end
  end
end

hs.hotkey.bind({ "cmd", "shift" }, "m", function()
  spaces.toggleMissionControl()
end)

for i = 1, 10, 1 do
  local binding = tostring(i)

  if binding == "10" then
    binding = "0"
  end

  hs.hotkey.bind({ "cmd", "shift" }, binding, function()
    spaces.goToSpace(getSpace(1).id)
  end)
end

refreshState()

return M
