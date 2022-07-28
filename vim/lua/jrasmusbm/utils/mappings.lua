local M = {}

local map_wrapper = function(mode, left, right, opts)
  if opts == nil then
    opts = {}
  end

  if opts.buffer then
    opts.buffer = nil
    vim.api.nvim_buf_set_keymap(0, mode, left, right, opts)
  else
    vim.api.nvim_set_keymap(mode, left, right, opts)
  end
end

M.nmap = function(left, right, opts)
  map_wrapper("n", left, right, opts)
end

M.vmap = function(left, right, opts)
  map_wrapper("v", left, right, opts)
end

M.omap = function(left, right, opts)
  map_wrapper("o", left, right, opts)
end

M.imap = function(left, right, opts)
  map_wrapper("i", left, right, opts)
end

M.xmap = function(left, right, opts)
  map_wrapper("x", left, right, opts)
end

M.feedkeys = function(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    "",
    false
  )
end

return M
