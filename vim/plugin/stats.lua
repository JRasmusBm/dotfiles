local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd vim-vmath
]]

mappings.nmap("<leader>st", ":call VMATH_Analyse()<CR>", { noremap = true })
mappings.nmap("<leader>st", "y:call VMATH_Analyse()<CR>", { noremap = true })
