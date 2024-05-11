local M = {}

M.emojify = function()
  vim.opt.completefunc = "emoji#complete"

  local pos = vim.fn.getpos "."

  pcall(function()
    vim.cmd [[ keeppatterns silent %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g ]]
  end)

  vim.fn.setpos(".", pos)
end

return M
