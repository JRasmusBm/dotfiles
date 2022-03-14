local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local ls_utils = require "jrasmusbm.snippets.utils"

ls.snippets.tsx = {
  s(
    { trig = "rf", name = "react file" },
    fmt(
      'import * as React from "react"\n\ninterface {}Props {{\n  {}\n}}\n\nconst {}: React.FC<{}Props> = ({{{}}}) => {{\n  return ({})\n}}\n\nexport default {}',
      { i(1), i(2), rep(1), rep(1), i(3), i(0, "null"), rep(1) }
    )
  ),
  s(
    { trig = "rc", name = "react component" },
    fmt(
      "interface {}Props {{\n  {}\n}}\n\nconst {}: React.FC<{}Props> = ({{{}}}) => {{\n  return ({})\n}}",
      { rep(1), i(2), i(1), rep(1), i(3), i(0, "null") }
    )
  ),
}

ls_utils.load_shared(ls.snippets.tsx, "html")
ls_utils.load_shared(ls.snippets.tsx, "css")
ls_utils.load_shared(ls.snippets.tsx, "graphql")
ls_utils.load_shared(ls.snippets.tsx, "react")
