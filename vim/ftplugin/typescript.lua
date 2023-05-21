require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"
require("plenary.reload").reload_module "jrasmusbm.treesitter.utils"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local ls_utils = require "jrasmusbm.snippets.utils"

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
})

ls_utils.load_shared { filetype = "typescript", shared = "js_ts" }
