vim.cmd [[
execute "source $DOTFILES/vim/snippets/css.vim"
execute "source $DOTFILES/vim/snippets/html.vim"
execute "source $DOTFILES/vim/snippets/graphql.vim"

command! Lint cex system("npm run lint -- --format=unix") <Bar> copen
]]

local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require("jrasmusbm.snippets.utils.init")
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.snippets.javascript = {}

require("plenary.reload").reload_module("jrasmusbm.snippets.shared.js_ts")

for _, snippet in pairs(require("jrasmusbm.snippets.shared.js_ts")) do
  table.insert(ls.snippets.javascript, snippet())
end
