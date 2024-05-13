require("plenary").reload.reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local ls_utils = require "jrasmusbm.snippets.utils"

require("jrasmusbm.matchit").load_html_pairs()

ls.add_snippets("jsx", {
  s(
    { trig = "rf", name = "react file" },
    fmt(
      'import * as React from "react"\n\nconst {} = ({{{}}}) => {{\n  return ({})\n}}\n\nexport default {}',
      { i(1), i(2), i(0, "null"), rep(1) }
    )
  ),
  s(
    { trig = "rc", name = "react component" },
    fmt(
      "const {} = ({}) => {{\n  return ({{{}}})\n}}",
      { i(1), i(2), i(0, "null") }
    )
  ),
})

ls_utils.load_shared { filetype = "jsx", shared = "html" }
ls_utils.load_shared { filetype = "jsx", shared = "css" }
ls_utils.load_shared { filetype = "jsx", shared = "graphql" }
ls_utils.load_shared { filetype = "jsx", shared = "react" }
