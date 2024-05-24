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

M.open_tree = function(num_lines)
  vim.cmd "e temp_git_tree"
  vim.bo.filetype = "git-commit-tree"
  require("jrasmusbm.git").list_tree(num_lines)
end

M.list_tree = function(num_lines)
  if vim.bo.filetype == "git-commit-tree" then
    if num_lines == nil then
      num_lines = 400
    end

    vim.cmd("silent %!git ll --silent -" .. num_lines)
    vim.cmd "silent write"
  end
end

return M
