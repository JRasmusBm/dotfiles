local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.add_snippets("express", {
  s(
    { trig = "rg", name = "get endpoint" },
    fmt(
      [[
router.get("{}", (req, res) => {{
  {}
}})

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "rpu", name = "put endpoint" },
    fmt(
      [[
router.put("{}", (req, res) => {{
  {}
}})

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "rpo", name = "post endpoint" },
    fmt(
      [[
router.post("{}", (req, res) => {{
  {}
}})

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "rd", name = "delete endpoint" },
    fmt(
      [[
router.delete("{}", (req, res) => {{
  {}
}})

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "rum", name = "use middleware" },
    fmt(
      [[
router.use({})
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "rm", name = "middleware" },
    fmt(
      [[
(_req, _res, _next)  => {{
  {}
}}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "rh", name = "handle errors" },
    fmt(
      [[
(_err, _req, _res, _next) => {{
  {}  
}}

{}
]],
      { i(1), i(0) }
    )
  ),
})
