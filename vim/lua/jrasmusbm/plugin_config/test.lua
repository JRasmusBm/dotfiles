vim.cmd [[
packadd! vim-test

let test#python#project_root = "./tests"
let test#strategy = "vtr"

let test#go#gotest#options = "-cover"
let test#javascript#reactscripts#options = "--coverage --watchAll=false"

nmap <silent> <localleader>dn :TestNearest<CR>
nmap <silent> <localleader>df :TestFile<CR>
nmap <silent> <localleader>ds :TestSuite<CR>
nmap <silent> <localleader>dp :TestLast<CR>
nmap <silent> <localleader>dv :TestVisit<CR>
]]
