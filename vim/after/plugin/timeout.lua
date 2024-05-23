vim.opt.ttimeoutlen = 0

local slow = 2000
local fast = 350

if require("jrasmusbm.compat").in_termux() then
  vim.opt.timeoutlen = slow
else
  vim.opt.timeoutlen = fast
end

vim.api.nvim_create_user_command("Fast", function()
  vim.opt.timeoutlen = fast
end, { nargs = 0 })

vim.api.nvim_create_user_command("Slow", function()
  vim.opt.timeoutlen = slow
end, { nargs = 0 })
