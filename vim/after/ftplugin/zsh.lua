require("plenary").reload.reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

vim.keymap.set({ "n" }, "zf", function()
  require("jrasmusbm.folds").fold_selection()
end, { expr = true })

ls.add_snippets("zsh", {})

ls_utils.load_shared { filetype = "zsh", shared = "sh" }
