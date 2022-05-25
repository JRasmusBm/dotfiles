local M = {}

M.get_current_theme = function()
  io.input(vim.fn.getenv "HOME" .. "/.config/jrasmusbm/theme")
  local theme = io.read()
  io.close()
  return theme
end

return M
