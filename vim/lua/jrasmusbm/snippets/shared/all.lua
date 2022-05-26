local ls = require "luasnip"

local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("all", {
  s(
    { trig = "!sh", name = "shell script" },
    fmt(
      [[
#!/bin/sh

set -e

_{}() {{
    {}
}}

_{} "$@"
    ]],
      { i(1), i(0), rep(1) }
    )
  ),

  s(
    { trig = "!bash", name = "bash script" },
    fmt(
      [[
#!/bin/bash

set -e

_{}() {{
    {}
}}

_{} "$@"
    ]],
      { i(1), i(0), rep(1) }
    )
  ),
})
