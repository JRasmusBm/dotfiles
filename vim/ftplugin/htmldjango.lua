local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.add_snippets("htmldjango", {})

ls_utils.load_shared({filetype = "htmldjango", shared = "html"})
ls_utils.load_shared({filetype = "htmldjango", shared = "css"})
