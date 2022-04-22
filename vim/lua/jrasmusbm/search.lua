local M = {}

M.set_search_as_x = function()
  vim.cmd [[
    let @x = @/[4:-3]
  ]]
end

return M
