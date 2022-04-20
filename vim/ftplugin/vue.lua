vim.cmd [[
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/sql.vim"
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/vue.vim"
]]

vim.b.is_markdown_file = false

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.add_snippets("vue", {})

ls_utils.load_shared({filetype = "vue", shared = "html"})
