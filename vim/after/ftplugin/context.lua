vim.cmd [[
match BadWhitespace /\s\+$/
]]

vim.opt.textwidth = 60
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.add_snippets("context", {})

ls_utils.load_shared { filetype = "context", shared = "latex" }
