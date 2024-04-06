local M = {}

M.feedkeys = function(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    "",
    false
  )
end

M.with_textobject = function(action)
  return function()
    local old_func = vim.go.operatorfunc
    _G.op_func_helper = function()
      _G.op_func_helper = nil
      vim.go.operatorfunc = old_func
      local start = vim.api.nvim_buf_get_mark(0, "[")
      local end_ = vim.api.nvim_buf_get_mark(0, "]")
      action(start, end_)
    end
    vim.go.operatorfunc = "v:lua.op_func_helper"
    vim.api.nvim_feedkeys("g@", "n", false)
  end
end

return M
