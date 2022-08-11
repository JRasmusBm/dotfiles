require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils"

ls.add_snippets("scss", {})

ls_utils.load_shared({filetype = "scss", shared = "css"})
