vim.opt_local.foldmethod = "marker"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local d = ls.dynamic_node

ls.add_snippets("haskell", {
  s(
    { trig = "tf", name = "function type" },
    fmt(
      [[
{} :: {} -> {}
{}
 ]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "tv", name = "variable type" },
    fmt(
      [[
{} :: {}
{}
 ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ta", name = "type alias" },
    fmt(
      [[
type {} = {}
{}
 ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "tn", name = "type node" },
    fmt(
      [[
{} ->
 ]],
      { i(0) }
    )
  ),

  s(
    { trig = "tc", name = "type constraint" },
    fmt(
      [[
({}) => {}
{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "td", name = "data type" },
    fmt(
      [[
data {} = {} deriving ({})

{}
  ]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "cd", name = "class definition" },
    fmt(
      [[
class {} where
{}

{}]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "is", name = "instance" },
    fmt(
      [[
instance {} where
{}

{}]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ex", name = "export" },
    fmt(
      [[
module {} where

{}]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "im", name = "import module" },
    fmt(
      [[
import {}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "em", name = "map expression" },
    fmt(
      [[
[ {} | {} <- {} ]
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "fi", name = "function inline" },
    fmt(
      [[
(\{} -> {}) {}
]],
      { i(1), i(2), i(0) }
    )
  ),
})
