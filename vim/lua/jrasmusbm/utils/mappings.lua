local M = {}

local map_wrapper = function(mode, left, right, opts)
  if opts == nil then opts = {} end

  vim.api.nvim_set_keymap(mode, left, right, opts)
end

M.nmap = function(left, right, opts) map_wrapper("n", left, right, opts) end

M.vmap = function(left, right, opts) map_wrapper("v", left, right, opts) end

M.omap = function(left, right, opts) map_wrapper("o", left, right, opts) end

M.imap = function(left, right, opts) map_wrapper("i", left, right, opts) end

return M
