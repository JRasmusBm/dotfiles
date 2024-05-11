local M = {}

M.open_github_link = function()
  local line_number = vim.fn.line "."
  local line = vim.fn.getbufline(vim.fn.bufnr "%", line_number)[1]
  local column_start = vim.fn.getpos("v")[3]
  local column_end = vim.fn.getpos(".")[3]
  local selection =
      vim.fn.strpart(line, column_start - 1, column_end - column_start + 1)
  vim.fn.system("git-repo " .. selection)
end

return M
