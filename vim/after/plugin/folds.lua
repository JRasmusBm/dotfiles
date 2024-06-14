vim.cmd [[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

augroup CustomFoldlevel
  autocmd BufRead *.test.* setlocal foldlevel=1
augroup END

set foldlevel=10
]]

vim.keymap.set(
  { "n" },
  "<leader>zs",
  "<cmd>setlocal foldmethod=syntax<cmd>",
  { noremap = true }
)
vim.keymap.set(
  { "n" },
  "<leader>zm",
  "<cmd>setlocal foldmethod=marker<cmd>",
  { noremap = true }
)

vim.keymap.set(
  { "n" },
  "<leader>ze",
  "<cmd>setlocal foldmethod=expr<cmd>",
  { noremap = true }
)

vim.opt.foldopen = require("jrasmusbm.utils.options").list {
  "block",
  "hor",
  "insert",
  "percent",
  "mark",
  "search",
  "tag",
  "undo",
  "quickfix",
}

vim.opt.foldclose = ""
