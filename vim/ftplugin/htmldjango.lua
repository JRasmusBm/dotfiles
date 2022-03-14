local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.snippets.htmldjango = {}

ls_utils.load_shared(ls.snippets.htmldjango, "html")
ls_utils.load_shared(ls.snippets.htmldjango, "css")
