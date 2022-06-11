vim.cmd [[
packadd nvim-cmp
packadd cmp-nvim-lsp
packadd cmp-path
packadd cmp-buffer
packadd cmp-cmdline
packadd cmp_luasnip
]]

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.complete = require("jrasmusbm.utils.options").list {
  ".",
  "w",
  "b",
  "u",
  "kspell",
  "i",
}

vim.opt.isfname = require("jrasmusbm.utils.options").list {
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
