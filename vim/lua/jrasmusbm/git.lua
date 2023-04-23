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

local bang_marker = function(options)
  if options.bang then
    return "!"
  end
  return ""
end

M.run_command = function(options)
  if options.fargs[1] == "browse" or options.fargs[1] == "br" then
    table.remove(options.fargs, 1)
    require("jrasmusbm.utils.commands").run("GBrowse", options)
    return
  end

  if options.fargs[1] == "bl" then
    options.fargs[1] = "blame"
    return
  end

  require("jrasmusbm.utils.commands").run("Git", options)
end

return M
