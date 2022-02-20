vim.cmd [[
execute "source $DOTFILES/vim/snippets/css.vim"
]]

local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local ls_utils = require("jrasmusbm.snippets.utils")

ls.snippets.typescript = {
  s({trig = "at", name = "typed argument"},
    fmt("{}: {},\n{}", {i(1), i(2), i(0)})),

  s({trig = "ti", name = "interface"},
    fmt("interface {} {{\n  {}\n}}\n\n{}", {i(1), i(2), i(0)})),
  s({trig = "ta", name = "type"}, fmt("type {} = {}\n{}", {i(1), i(2), i(0)})),
}

ls_utils.load_shared(ls.snippets.typescript, "js_ts")
ls_utils.load_shared(ls.snippets.typescript, "html")
ls_utils.load_shared(ls.snippets.typescript, "graphql")
