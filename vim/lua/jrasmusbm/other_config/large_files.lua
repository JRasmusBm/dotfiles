local M = {}

local options = require("jrasmusbm.utils.options")
local scroll = require("jrasmusbm.plugin_config.scroll")

vim.cmd [[
augroup LargeFile
 autocmd!
 autocmd BufReadPre * lua require("jrasmusbm.other_config.large_files").buf_read_pre(vim.fn.expand("<afile>"))
 autocmd BufReadPost * lua require("jrasmusbm.other_config.large_files").buf_read_post()
 augroup END
]]
local previous_settings = {}

local estimated_bytes_per_line = 50
local max_lines = 2000
M.large_file_limit_bytes = max_lines * estimated_bytes_per_line

local function is_large_file(file_path)
  return M.large_file_limit_bytes < vim.fn.getfsize(file_path)
end

M.buf_enter = function()
  scroll.reset_mappings()
end

M.buf_leave = function()
  scroll.declare_mappings()
end

M.buf_read_pre = function(file_path)
  if not is_large_file(file_path) then return end

  previous_settings.eventignore = vim.o.eventignore
  vim.o.eventignore = options.list {"FileType"}

  vim.cmd [[
   augroup LargeFileEnter
     autocmd BufEnter <buffer> lua require("jrasmusbm.other_config.large_files").buf_enter()
     autocmd BufLeave <buffer> lua require("jrasmusbm.other_config.large_files").buf_leave()
   augroup END
  ]]
end

M.buf_read_post = function()
  if previous_settings.eventignore ~= nil then
    vim.o.eventignore = previous_settings.eventignore
  end
end

return M
