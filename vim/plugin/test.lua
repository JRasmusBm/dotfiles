local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd vim-test

let test#python#project_root = "./tests"
let test#strategy = "vtr"

let test#go#gotest#options = "-cover"
let test#javascript#reactscripts#options = "--coverage --watchAll=false"
]]

mappings.nmap("<localleader>dn", ":TestNearest<CR>", { noremap = true })
mappings.nmap("<localleader>df", ":TestFile<CR>", { noremap = true })
mappings.nmap("<localleader>ds", ":TestSuite<CR>", { noremap = true })
mappings.nmap("<localleader>dp", ":TestLast<CR>", { noremap = true })
mappings.nmap("<localleader>dv", ":TestVisit<CR>", { noremap = true })
