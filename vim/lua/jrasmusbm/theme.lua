local M = {}

M.get_current_theme = function()
  local filename = vim.fn.getenv "LOCAL_CONFIG" .. "/theme"
  if io.open(filename) == nil then
    return "dark"
  end

  io.input(filename)
  local theme = io.read()
  io.close()
  return theme
end

return M
