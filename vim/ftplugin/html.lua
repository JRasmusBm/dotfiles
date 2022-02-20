if vim.b.is_markdown_file then return end

vim.cmd [[
execute "source $DOTFILES/vim/snippets/css.vim"
]]

local ls = require("luasnip")
local ls_utils = require("jrasmusbm.snippets.utils.init")

ls.snippets.html = {}

ls_utils.load_shared(ls.snippets.html, "html")
