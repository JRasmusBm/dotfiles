local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.snippets.tsx = {
  s({trig = "rf", name = "react file"}, fmt(
      "import * as React from \"react\"\n\ninterface {}Props {{\n  {}\n}}\n\nconst {}: React.FC<{}Props> = ({}) => {{\n  return ({})\n}}\n\nexport default {}",
      {rep(1), i(2), i(1), rep(1), i(3), i(0, "null"), rep(1)})),
  s({trig = "rc", name = "react component"}, fmt(
      "interface {}Props {{\n  {}\n}}\n\nconst {}: React.FC<{}Props> = ({}) => {{\n  return ({})\n}}",
      {rep(1), i(2), i(1), rep(1), i(3), i(0, "null")})),

  s({trig = "he", name = "useEffect hook"},
    fmt("useEffect(() => {{\n  {}\n}}, [{}])\n\n{}", {i(1), i(2), i(0)})),
  s({trig = "hl", name = "useLayoutEffect hook"},
    fmt("useLayoutEffect(() => {{\n  {}\n}}, [{}])\n\n{}", {i(1), i(2), i(0)})),
}
