local M = {}

local BIN = os.getenv "HOME" .. "/projects/dotfiles/bin/"
local SCRIPTS = { "mem-snapshot", "lsp-reclaim" }

local function tick()
  for _, script in ipairs(SCRIPTS) do
    hs.task.new("/bin/sh", nil, { "-lc", BIN .. script }):start()
  end
end

M.timer = hs.timer.doEvery(60, tick)
tick()

return M
