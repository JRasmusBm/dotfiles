local M = {}

local options = require("jrasmusbm.utils.options")

vim.cmd [[
augroup LargeFile
 autocmd!
 autocmd BufReadPre * lua require("jrasmusbm.other_config.large_files").handle_large_file()
 autocmd BufReadPost * lua require("jrasmusbm.other_config.large_files").clean_up_large_file()
 augroup END
]]

M.large_file_limit = 3000

local function is_large_file()
  return false
  -- return M.large_file_limit < vim.api.nvim_buf_line_count(0)
end

M.handle_buf_enter = function() end

M.handle_buf_leave = function() end

M.handle_large_file = function()
  if not is_large_file() then return end

  vim.bo.eventignore = options.list {"FileType"}

  vim.cmd [[
   augroup LargeFileEnter
     autocmd LargeFile BufEnter <buffer> lua require("jrasmusbm.other_config.large_files").handle_buf_enter()
     autocmd LargeFile BufLeave <buffer> lua require("jrasmusbm.other_config.large_files").handle_buf_leave()
   augroup END
  ]]
end

M.clean_up_large_file = function() if not is_large_file() then return end end

return M
