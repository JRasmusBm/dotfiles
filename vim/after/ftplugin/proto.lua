local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("proto", {
  s(
    { trig = "m", name = "message" },
    fmt(
      [[
message {} {{
  {}
}}
{}]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "s", name = "service" },
    fmt(
      [[
service {} {{
  {}
}}
{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "r", name = "rpc" },
    fmt(
      [[
rpc {}({}Req) returns ({}Resp) {{}}
{}
  ]],
      { i(1), rep(1), rep(1), i(0) }
    )
  ),

  s(
    { trig = "l", name = "list" },
    fmt(
      [[
repeated {}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "f", name = "field" },
    fmt(
      [[
{} = 0;
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fs", name = "field string" },
    fmt(
      [[
string {} = 0;
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fi", name = "field int" },
    fmt(
      [[
int32 {} = 0;
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fb", name = "field bool" },
    fmt(
      [[
bool {} = 0;
{}
]],
      { i(1), i(0) }
    )
  ),
})
