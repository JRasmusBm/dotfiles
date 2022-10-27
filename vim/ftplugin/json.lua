local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

require("jrasmusbm.utils").ensure_setup("vim-json")

ls.add_snippets("json", {
  s(
    { trig = "js", name = "string" },
    fmt(
      [[
"{}": "{}",
{}
    ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "jp", name = "plain" },
    fmt(
      [[
"{}": {},
{}
    ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "jo", name = "object" },
    fmt(
      [[
"{}": {{
  {}
}}
{}
    ]],
      { i(1), i(2), i(0) }
    )
  ),
})
