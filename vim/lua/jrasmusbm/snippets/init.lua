local M = {}

M.ensure_setup = function ()
  if require("jrasmusbm.utils").ensure_setup("LuaSnip") then
    return false
  end
  
  require("jrasmusbm.utils").ensure_setup("vim-bushels")

  local edit_utils = require "jrasmusbm.utils.edit"
  local ls = require "luasnip"
  require "jrasmusbm.snippets.shared.all"

  ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  ls.filetype_extend("tsx", { "html", "css" })
  ls.filetype_extend("jsx", { "html", "css" })
  ls.filetype_extend("typescript", { "graphql" })
  ls.filetype_extend("graphql", { "javascript" })

  return true
end

return M
