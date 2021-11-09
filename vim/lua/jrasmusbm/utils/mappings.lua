local M = {}

M.nmap = function (left, right)
  vim.api.nvim_set_keymap("n", left, right, {})
end

M.vmap = function (left, right)
  vim.api.nvim_set_keymap("v", left, right, {})
end


return M
