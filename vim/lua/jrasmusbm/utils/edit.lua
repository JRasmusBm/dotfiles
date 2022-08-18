local M = {}

M.feedkeys = function(keys, modes)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    modes or "",
    false
  )
end

M.add_undo_breakpoint = function()
  M.feedkeys("<c-g>u", "i")
end

return M
