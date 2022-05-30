vim.cmd [[
match BadWhitespace /\s\+$/

execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/latex.vim"
]]

vim.opt.textwidth = 60
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

local ls = require("luasnip")
local ls_utils = require("jrasmusbm.snippets.utils.init")

ls.add_snippets("tex", {})

ls_utils.load_shared({filetype = "tex", shared = "latex"})
