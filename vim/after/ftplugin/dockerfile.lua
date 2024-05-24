local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.add_snippets("dockerfile", {
  s(
    { trig = "f", name = "from" },
    fmt(
      [[
FROM {}:{}

{}]],
      { i(1), i(2), i(0) }
    )
  ),
})
