local M = {}

function M.emojify()
  vim.opt.completefunc = "emoji#complete"

  vim.cmd [[
  packadd vim-emoji
  ]]

  local pos = vim.fn.getpos "."
  vim.cmd [[ keeppatterns %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g ]]
  vim.fn.setpos(".", pos)
end

return M
