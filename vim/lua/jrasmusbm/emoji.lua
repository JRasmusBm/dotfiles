local M = {}

function M.emojify()
  vim.opt.completefunc = "emoji#complete"

  require("jrasmusbm.utils").ensure_setup(" vim-emoji")

  local pos = vim.fn.getpos "."
  vim.cmd [[ keeppatterns silent %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g ]]
  vim.fn.setpos(".", pos)
end

return M
