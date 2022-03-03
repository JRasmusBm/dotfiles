local M = {}

M.finish_file = function()
  if vim.fn.line(".") ~= vim.api.nvim_buf_line_count(0) then vim.cmd(".+1,$d") end

  vim.cmd [[
  w!
  bd!
  ]]
end

return M
