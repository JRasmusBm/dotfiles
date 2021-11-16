local M = {}

local options = require("jrasmusbm.utils.options")
local scroll = require("jrasmusbm.plugin_config.scroll")

vim.cmd [[
augroup LargeFile
 autocmd!
 autocmd BufReadPre * lua require("jrasmusbm.other_config.large_files").buf_read_pre(vim.fn.expand("<afile>:p"))
 autocmd BufReadPost * lua require("jrasmusbm.other_config.large_files").buf_read_post(vim.fn.expand("<afile:p>"))
 augroup END
]]
local previous_settings = {}

local estimated_bytes_per_line = 50
local max_lines = 2000
M.large_file_limit_bytes = max_lines * estimated_bytes_per_line

local function is_large_file(file_path)
  local size_in_bytes = vim.fn.getfsize(file_path)
  return M.large_file_limit_bytes < size_in_bytes
end

M.buf_enter = function()
  scroll.reset_mappings()
  vim.cmd [[
  NoMatchParen
  IlluminationDisable
  ]]
end

M.buf_leave = function()
  scroll.declare_mappings()
  vim.cmd [[
  DoMatchParen
  IlluminationEnable
  ]]
end

M.buf_read_pre = function(file_path)
  if not is_large_file(file_path) then return end

  previous_settings.eventignore = vim.o.eventignore
  vim.opt.eventignore = options.list {"FileType"}

  local augroup_name= "LargeFileEnter" ..vim.fn.substitute(file_path, "\\A", "", "g")
  vim.cmd ("augroup " .. augroup_name .. [[
     autocmd BufEnter <buffer> lua require("jrasmusbm.other_config.large_files").buf_enter(vim.fn.expand("<afile:p>"))
     autocmd BufLeave <buffer> lua require("jrasmusbm.other_config.large_files").buf_leave(vim.fn.expand("<afile:p>"))
   augroup END
   ]])
end

M.buf_read_post = function()
  if previous_settings.eventignore ~= nil then
    vim.opt.eventignore = previous_settings.eventignore
  end
end

M.buf_read_pre(vim.fn.expand("%:p"))

return M
