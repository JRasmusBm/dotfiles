vim.cmd [[
command! Lint cex system("npm run lint -- --format=unix") <Bar> copen
]]

local ls = require("luasnip")
local ls_utils = require("jrasmusbm.snippets.utils.init")

ls.snippets.javascript = {}

ls_utils.load_shared(ls.snippets.javascript, "js_ts")
ls_utils.load_shared(ls.snippets.javascript, "html")
ls_utils.load_shared(ls.snippets.javascript, "css")
ls_utils.load_shared(ls.snippets.javascript, "graphql")
