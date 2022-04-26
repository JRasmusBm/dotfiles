vim.cmd [[
command! PR norm gg/Ticketf[yi]/#f[v2f]p0WysaW]Wdw
]]

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }
vim.opt_local.wrap = true
vim.b.is_markdown_file = true
vim.opt_local.textwidth = 80

require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("markdown", {
  s(
    { trig = "nf", name = "notes file" },
    fmt(
      [[
---
title: "{}"
tags:
  - "{}"
---

# {}

{}
]],
      { i(1), i(2), rep(1), i(0) }
    )
  ),
})

ls_utils.load_shared { filetype = "markdown", shared = "markdown" }
