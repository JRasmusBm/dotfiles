require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"
require("jrasmusbm.utils").ensure_loaded "vim-graphql"

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils"

ls.add_snippets("graphql", {})

ls_utils.load_shared({filetype = "graphql", shared = "graphql"})
