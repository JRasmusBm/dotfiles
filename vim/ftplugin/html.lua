if vim.b.is_markdown_file then
  return
end

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.snippets.html = {}

ls_utils.load_shared(ls.snippets.html, "html")
ls_utils.load_shared(ls.snippets.html, "css")
