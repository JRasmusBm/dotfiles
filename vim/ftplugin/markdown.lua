vim.cmd [[
command! PR norm gg/Ticketf[yi]/#f[v2f]p0WysaW]Wdw
]]

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }
vim.opt_local.wrap = true
vim.b.is_markdown_file = true
vim.opt_local.textwidth = 80

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.add_snippets("markdown", {})

ls_utils.load_shared({filetype = "markdown", shared = "markdown"})
