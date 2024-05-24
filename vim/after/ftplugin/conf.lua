vim.opt_local.foldmethod = "marker"

if vim.fn.expand "%:t" == "termux.conf" then
  vim.keymap.set({ "n" }, "<localleader>tf", function()
    vim.cmd "!termux-reload-settings"
  end, { buffer = 0 })
end

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

vim.keymap.set({ "n" }, "zf", function()
  require("jrasmusbm.folds").fold_selection()
end, { buffer = true })

ls.add_snippets("conf", {
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
