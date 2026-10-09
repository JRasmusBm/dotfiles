local M = {}

local SCRIPT = os.getenv("HOME") .. "/projects/dotfiles/bin/mem-snapshot"

local function snapshot()
  hs.task.new("/bin/sh", nil, { "-lc", SCRIPT }):start()
end

M.timer = hs.timer.doEvery(60, snapshot)
snapshot()

return M
