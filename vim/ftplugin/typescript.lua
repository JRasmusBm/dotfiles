vim.cmd [[
execute "source $DOTFILES/vim/snippets/css.vim"
execute "source $DOTFILES/vim/snippets/html.vim"
execute "source $DOTFILES/vim/snippets/graphql.vim"
]]

local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.snippets.typescript = {
  s({trig = "at", name = "typed argument"},
    fmt("{}: {},\n{}", {i(1), i(2), i(0)})),

  s({trig = "ti", name = "interface"},
    fmt("interface {} {{\n  {}\n}}\n\n{}", {i(1), i(2), i(0)})),
  s({trig = "ta", name = "type"}, fmt("type {} = {}\n{}", {i(1), i(2), i(0)})),
}

require("plenary.reload").reload_module("jrasmusbm.snippets.shared.js_ts")

for _, snippet in pairs(require("jrasmusbm.snippets.shared.js_ts")) do
  table.insert(ls.snippets.typescript, snippet())
end
