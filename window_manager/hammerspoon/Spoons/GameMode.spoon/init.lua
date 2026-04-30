local M = {
  hotkeys = {},
  games = {
    ["League of Legends"] = true,
    ["SC2"] = true,
    ["Warcraft III"] = true,
  },
  active = false,
}

function M:register(hk)
  table.insert(self.hotkeys, hk)
  if self.active then hk:disable() end
  return hk
end

local function setEnabled(on)
  for _, hk in ipairs(M.hotkeys) do
    if on then hk:enable() else hk:disable() end
  end
end

M.watcher = hs.application.watcher.new(function(name, evt, _)
  if not M.games[name] then return end
  if evt == hs.application.watcher.activated then
    M.active = true
    setEnabled(false)
  elseif evt == hs.application.watcher.deactivated
      or evt == hs.application.watcher.terminated then
    M.active = false
    setEnabled(true)
  end
end)
M.watcher:start()

local front = hs.application.frontmostApplication()
if front and M.games[front:name()] then
  M.active = true
end

spoon.GameMode = M
return M
