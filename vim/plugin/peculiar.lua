local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd vim-peculiar
]]

mappings.nmap("<localleader>v", "<Plug>PeculiarV")
mappings.nmap("<localleader>g", "<Plug>PeculiarG")
mappings.nmap("<localleader>n", "<Plug>PeculiarN")
mappings.nmap("<localleader>r", "<Plug>PeculiarR")

vim.g["peculiar#suppress_highlight_n"] = 1
