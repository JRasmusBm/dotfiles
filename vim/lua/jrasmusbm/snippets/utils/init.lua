local M = {}

local ls = require "luasnip"
local sn = ls.snippet_node
local t = ls.text_node

M.line_number = function(_, _)
  return sn(0, { t(tostring(vim.fn.line ".")) })
end

M.file_path = function(_, _)
  return sn(0, { t(vim.fn.expand "%") })
end

M.file_name = function(_, _)
  return sn(0, { t(vim.fn.expand "%:p:h") })
end

M.load_shared = function(options)
  local module_name = "jrasmusbm.snippets.shared." .. options.shared

  require("plenary.reload").reload_module(module_name)

  local snippets = {}

  for _, snippet in pairs(require(module_name)) do
    table.insert(snippets, snippet())
  end

  ls.add_snippets(options.filetype, snippets)
end

return M
