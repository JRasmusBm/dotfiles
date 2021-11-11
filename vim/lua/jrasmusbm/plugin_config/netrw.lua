local mappings = require("jrasmusbm.utils.mappings")

vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.g.netrw_menu = 0
vim.g.netrw_banner = 0
vim.g.netrw_http_cmd = "br"

mappings.nmap("<Leader>d", ":Ex<CR>", {noremap = true})
