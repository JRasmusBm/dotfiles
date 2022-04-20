local M = {}

vim.cmd [[
packadd! vim-emoji
command! Emojify lua require("jrasmusbm.emoji").emojify()
]]

vim.opt.completefunc = "emoji#complete"

function M.emojify()
  local pos = vim.fn.getpos "."
  vim.cmd [[ keeppatterns %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g ]]
  vim.fn.setpos(".", pos)
end

return M
