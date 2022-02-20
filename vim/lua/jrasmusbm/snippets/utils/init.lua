local M = {}

local ls = require("luasnip")
local sn = ls.snippet_node
local t = ls.text_node

M.line_number = function(_, _) return sn(0, {t(tostring(vim.fn.line(".")))}) end

M.file_name = function(_, _) return sn(0, {t(vim.fn.expand("%"))}) end

M.load_shared = function(snippets, file)
  local module_name = "jrasmusbm.snippets.shared." .. file

  require("plenary.reload").reload_module(module_name)

  for _, snippet in pairs(require(module_name)) do
    table.insert(snippets, snippet())
  end
end

return M
