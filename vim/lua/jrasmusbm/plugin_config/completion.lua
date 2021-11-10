local mappings = require("jrasmusbm.utils.mappings")

vim.cmd [[
packadd! nvim-compe
]]

vim.opt.completeopt = {"menuone", "noselect"}


mappings.imap("<C-Space>", "compe#complete()", {silent = true, expr = true})
mappings.imap("<C-y>", "compe#confirm('<CR>')", {silent = true, expr = true})
mappings.imap("<C-e>", "compe#close('<C-e>')", {silent = true, expr = true})
mappings.imap("<C-u>", "compe#scroll({ 'delta': -4 })",
              {silent = true, expr = true})
mappings.imap("<C-d>", "compe#scroll({ 'delta': +4 })",
              {silent = true, expr = true})
