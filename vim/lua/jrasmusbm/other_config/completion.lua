vim.opt.complete=require("jrasmusbm.utils.options").list {
  ".",
  "w",
  "b",
  "u",
  "kspell",
  "i",
}

vim.opt.isfname=require("jrasmusbm.utils.options").list {
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
