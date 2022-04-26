require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

vim.opt.textwidth = 72
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }

vim.keymap.set({ "i" }, "<Leader>c", require("jrasmusbm.mappings").finish_file)

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.add_snippets("gitcommit", {})

ls_utils.load_shared({filetype = "gitcommit", shared = "markdown"})
