local mappings = require("jrasmusbm.utils.mappings")

mappings.imap("<CR>","<Esc>", {noremap=true})
mappings.imap("<C-h>","<Esc>", {noremap=true})
mappings.imap("<C-c>","<Esc>", {noremap=true})
mappings.nmap("Q","<nop>")
mappings.nmap("gQ","qqVipJ2jq2{w0")

mappings.imap("<leader>D","=strftime('%Y-%m-%d')<cr>", {noremap=true})
mappings.imap("<leader>T","=strftime('%H:%M')<cr>", {noremap=true})

mappings.nmap("go","o<Esc>S", {noremap=true})
mappings.nmap("gO","O<Esc>S", {noremap=true})

mappings.nmap("<leader>qo","<cmd>copen<cr>",{silent= true, noremap=true})
mappings.nmap("<leader>qc","<cmd>cclose<cr>",{silent= true, noremap=true})

mappings.nmap("<leader>lo","<cmd>lopen<cr>",{silent= true, noremap=true})
mappings.nmap("<leader>lc","<cmd>lclose<cr>",{silent= true, noremap=true})

mappings.xmap("<leader>h","<cmd>call jrasmusbm#open#github()<CR>")

mappings.nmap("==","<cmd>call jrasmusbm#format#default()<cr>")
