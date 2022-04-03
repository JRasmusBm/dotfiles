vim.cmd [[
command! Lint cex system("npm run lint -- --format=unix") <Bar> copen
]]

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.add_snippets("javascript", {})

ls_utils.load_shared({filetype = "javascript", shared = "js_ts"})
ls_utils.load_shared({filetype = "javascript", shared = "html"})
ls_utils.load_shared({filetype = "javascript", shared = "css"})
ls_utils.load_shared({filetype = "javascript", shared = "graphql"})
