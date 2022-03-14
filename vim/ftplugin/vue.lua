vim.cmd [[
execute "source $DOTFILES/vim/snippets/sql.vim"
execute "source $DOTFILES/vim/snippets/vue.vim"
]]

vim.b.is_markdown_file = false

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.snippets.vue = {}

ls_utils.load_shared(ls.snippets.vue, "html")
