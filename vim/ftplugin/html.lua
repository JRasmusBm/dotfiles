require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

if vim.b.is_markdown_file then
  return
end

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"

ls.add_snippets("html", {})

ls_utils.load_shared({filetype = "html", shared = "html"})
ls_utils.load_shared({filetype = "html", shared = "css"})
ls_utils.load_shared({filetype = "html", shared = "js_ts"})
