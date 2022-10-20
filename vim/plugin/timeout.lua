if require("jrasmusbm.compat").in_termux() then
  vim.opt.timeoutlen = 2000
else
  vim.opt.timeoutlen = 350
end
vim.opt.ttimeoutlen = 0
