vim.cmd [[
packadd nvim-cmp
packadd cmp-nvim-lsp
packadd cmp-path
packadd cmp-buffer
packadd cmp-cmdline
packadd cmp_luasnip
]]

local list = require("jrasmusbm.utils.options").list 

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.complete = list {
  ".",
  "w",
  "b",
  "u",
  "kspell",
  "i",
}

vim.opt.isfname = list {
  "@",
  "48-57",
  "/",
  ".",
  "-",
  "_",
  "+",
  ",",
  "#",
  "$",
  "%",
  "~",
  "=",
}
