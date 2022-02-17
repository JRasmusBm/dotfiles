local M = {}

local ls = require("luasnip")
local sn = ls.snippet_node
local t = ls.text_node

M.line_number = function(_, _) return sn(0, {t(tostring(vim.fn.line(".")))}) end

M.file_name = function(_, _) return sn(0, {t(vim.fn.expand("%"))}) end

return M
