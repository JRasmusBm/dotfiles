local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils"

ls.add_snippets("graphql", {})

ls_utils.load_shared({filetype = "graphql", shared = "graphql"})
