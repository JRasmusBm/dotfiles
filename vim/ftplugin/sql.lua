vim.cmd [[
execute "source $DOTFILES/vim/snippets/sql.vim"
]]

vim.fn.setreg("n", "dt,nvgnpdf @n")
vim.fn.setreg("c", "/\\v\\%s\n$i,0l@n")

vim.keymap.set({ "n" }, "==", function()
  vim.cmd [[
    %!sqlformat - -k upper -r --indent_columns --wrap_after 60
  ]]
end, { silent = true, buffer = 0 })

vim.keymap.set({ "n" }, ";c", "", {})
vim.g.VtrStripLeadingWhitespace = 0

vim.opt.formatprg = "sqlformat - -k upper -r --indent_columns --wrap_after 60"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.add_snippets("sql", {
  s(
    { trig = "running", name = "get running queries" },
    fmt(
      [[
SELECT pid, now() - backend_start, query
FROM pg_stat_activity
WHERE state = 'active'
  AND pid != pg_backend_pid()
  AND query !~~ 'START_REPLICATION%'
  ORDER B Y backend_start;
  ]],
      {}
    )
  ),
})
