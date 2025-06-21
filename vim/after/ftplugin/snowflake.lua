vim.fn.setreg("n", "dt,nvgnpdf @n")
vim.fn.setreg("c", "/\\v\\%s\n$i,0l@n")

vim.keymap.set({ "n" }, "==", function()
  vim.cmd [[
    %!sqlformat - -k upper -r --indent_columns --indent_width 2
  ]]
end, { silent = true, buffer = 0 })

vim.keymap.set({ "n" }, ";c", "", {})
vim.keymap.set({ "n" }, ";q", function()
  require("nvim-tmux-runner").send_lines_to_runner {
    "q;q;q;q;q;q;q;q;q;q;q;q;q;q;q;q;q;",
  }
end, {})

vim.g.VtrStripLeadingWhitespace = 0

vim.opt.formatprg = "sqlformat - -k upper -r --indent_columns --wrap_after 60"

local ls = require "luasnip"
local s = ls.s
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("snowflake", {
  s(
    { trig = "bai", name = "serial" },
    fmt(
      [[
BIGINT AUTOINCREMENT{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "bq", name = "get running queries" },
    fmt(
      [[
SELECT *
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
WHERE EXECUTION_STATUS = 'RUNNING'
ORDER BY START_TIME;
  ]],
      {}
    )
  ),
})
