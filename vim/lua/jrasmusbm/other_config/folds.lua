local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
augroup CustomFoldlevel
  autocmd BufRead *.test.* setlocal foldlevel=1
augroup END
]]

mappings.nmap("<leader>zs", "<cmd>setlocal foldmethod=syntax<cmd>", { noremap = true })
mappings.nmap("<leader>zm", "<cmd>setlocal foldmethod=marker<cmd>", { noremap = true })

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

mappings.nmap("za", "<cmd>call jrasmusbm#folds#toggle_foldopen()<cr>", { noremap = true })
