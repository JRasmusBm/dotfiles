local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils"

ls.add_snippets("css", {})

ls_utils.load_shared({filetype = "css", shared = "css"})
