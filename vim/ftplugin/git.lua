vim.opt.textwidth = 72
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.snippets.git = {}

ls_utils.load_shared(ls.snippets.git, "markdown")
