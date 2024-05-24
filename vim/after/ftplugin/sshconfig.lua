vim.opt_local.foldmethod = "marker"

vim.keymap.set({ "n" }, "zf", function()
  require("jrasmusbm.folds").fold_selection()
end, { buffer = true })

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.add_snippets("sshconfig", {
  s(
    { trig = "fo", name = "fold open" },
    fmt(
      [[
# {} {{{{{{
{}
# }}}}}}
{}
 ]],
      { i(1), i(2), i(0) }
    )
  ),
})
