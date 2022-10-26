vim.cmd [[
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/dosini.vim"
]]
local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.add_snippets("dosini", {
  s(
    { trig = "pi", name = "mypy ignore" },
    fmt(
      [[
[mypy-{}]
ignore_missing_imports=True

{}
]],
      { i(1), i(0) }
    )
  ),
})
