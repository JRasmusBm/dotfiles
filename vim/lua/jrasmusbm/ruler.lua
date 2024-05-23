local M = {}

M.is_visible = true

M.temporarily_disable = function()
  vim.opt.cursorline = false
  vim.opt.cursorcolumn = false
end

M.source = function()
  vim.opt.cursorline = M.is_visible
  vim.opt.cursorcolumn = M.is_visible
end

M.toggle = function()
  if M.is_visible then
    M.is_visible = false
  else
    M.is_visible = true
  end
  M.source()
end

return M
