local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd! refactoring.nvim
]]

mappings.vmap(
  "<leader>rf",
  ":lua require('jrasmusbm.telescope.refactoring').refactors()<CR>",
  { noremap = true, silent = true }
)
