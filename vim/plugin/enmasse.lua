local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd vim-enmasse
]]

mappings.nmap("<leader>fi", "<cmd>EnMasse<CR>", { noremap = true })
