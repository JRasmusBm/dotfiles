local nonvim_augroup = vim.api.nvim_create_augroup("nonvim", { clear = true })

vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile", "BufRead" }, {
  group = nonvim_augroup,
  pattern = { "*.pdf", "*.png", "*.jpg" },
  callback = function(opts)
    if vim.loop.os_uname().sysname == "Darwin" then
      vim.system { "open", opts.file }
    else
      vim.system { "xdg-open", opts.file }
    end
    vim.api.nvim_buf_delete(0, { force = true })
  end,
})
