local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

vim.keymap.set(
  { "n" },
  "zf",
  vim.fn["jrasmusbm#folds#fold_selection"],
  { expr = true }
)

ls.add_snippets("zsh", {})

ls_utils.load_shared({filetype = "zsh", shared = "sh"})
