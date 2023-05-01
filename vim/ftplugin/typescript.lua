require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local ls_utils = require "jrasmusbm.snippets.utils"

require("jrasmusbm.treesitter.parent").setup_parent_mappings({
  "function_declaration",
}, { { "name" } })

ls.add_snippets("typescript", {
  s(
    { trig = "at", name = "typed argument" },
    fmt("{}: {},\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "ti", name = "interface" },
    fmt("type {} = {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),
})

ls_utils.load_shared { filetype = "typescript", shared = "js_ts" }
