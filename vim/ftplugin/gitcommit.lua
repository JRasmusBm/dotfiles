require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

vim.opt.textwidth = 72
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }

vim.keymap.set({ "i" }, "<Leader>c", require("jrasmusbm.mappings").finish_file)

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.add_snippets("gitcommit", {
  s(
    { trig = "!f", name = "breaking feature" },
    fmt(
      [[
feat({})!: {}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "f", name = "feature" },
    fmt(
      [[
feat({}): {}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "b", name = "bug fix" },
    fmt(
      [[
fix({}): {}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "d", name = "documentation" },
    fmt(
      [[
docs({}): {}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "s", name = "style" },
    fmt(
      [[
style({}): {}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "r", name = "refactor" },
    fmt(
      [[
refactor({}): {}
    ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "t", name = "test" },
    fmt(
      [[
test({}): {}
    ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "c", name = "chore" },
    fmt(
      [[
chore({}): {}
    ]],
      { i(1), i(0) }
    )
  ),
})

ls_utils.load_shared { filetype = "gitcommit", shared = "markdown" }
