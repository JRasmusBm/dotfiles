require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"
require("plenary.reload").reload_module "jrasmusbm.treesitter.utils"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local ls_utils = require "jrasmusbm.snippets.utils"
local rep = require("luasnip.extras").rep

require("jrasmusbm.treesitter.setup_mappings").main("<leader>ao", {
  { { "function_declaration", "variable_declarator" }, { { "name" } } },
}, true)

require("jrasmusbm.treesitter.setup_mappings").main("<leader>ap", {
  {
    { "variable_declarator" },
    {
      {
        "arrow_function",
        "parameters",
        "required_parameter",
        "type",
        1,
      },
    },
  },
  {
    { "function_declaration", "function" },
    {
      {
        "parameters",
        "required_parameter",
        "type",
        1,
      },
    },
  },
  true,
})

ls.add_snippets("typescript", {
  s(
    { trig = "at", name = "typed argument" },
    fmt("{}: {},\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "ti", name = "interface" },
    fmt("type {} = {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "tef", name = "function type" },
    fmt(
      [[
({}) => void;
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ten", name = "number type" },
    fmt(
      [[
{}: number;
{}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "bp", name = "breakpoint" },
    fmt(
      [[
// eslint-disable-next-line
debugger;
  ]],
      {}
    )
  ),

  s(
    { trig = "tpp", name = "type pretty print" },
    fmt(
      [[
type Prettify<T> = {{
  [K in keyof T]: T[K];
}} & {{}}
{}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "dg", name = "mock data generator" },
    fmt(
      [[
const given{} = (overrides?: Partial<{}>): {} => {{
  return {{
    {},
    ...overrides,
  }}
}}
  ]],
      { rep(1), rep(1), i(1), i(0) }
    )
  ),
})

ls_utils.load_shared { filetype = "typescript", shared = "js_ts" }
