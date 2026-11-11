local list = require("jrasmusbm.utils.options").list

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.complete = list { ".", "w", "b", "u", "kspell", "i" }
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
