return {
  "LunarVim/bigfile.nvim",
  pattern = function(bufnr, filesize_mib)
    local lines = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
    if #lines > 5000 then
      return true
    end
  end
}
