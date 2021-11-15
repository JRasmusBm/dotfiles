local mappings = require("jrasmusbm.utils.mappings")

vim.cmd [[
packadd! vim-smoothie
]]

vim.g.smoothie_no_default_mappings = true
vim.g.smoothie_update_interval = 20
vim.g.smoothie_speed_constant_factor = 20
vim.g.smoothie_speed_linear_factor = 20
vim.g.smoothie_speed_exponentiation_factor = 0.95

local M = {}

M.declare_mappings = function()
  mappings.nmap("<C-D>", "<Plug>(SmoothieDownwards)")
  mappings.nmap("<C-U>", "<Plug>(SmoothieUpwards)")
end

M.reset_mappings = function()
  mappings.nmap("<C-D>", "<C-D>", {noremap = true})
  mappings.nmap("<C-U>", "<C-U>", {noremap = true})
end

return M
