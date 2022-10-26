require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

vim.keymap.set(
  { "n" },
  "zf",
  vim.fn["jrasmusbm#folds#fold_selection"],
  { expr = true }
)

ls.add_snippets("sh", {})

ls_utils.load_shared { filetype = "sh", shared = "sh" }
