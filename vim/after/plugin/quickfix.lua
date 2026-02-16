vim.keymap.set("n", "<leader>ql", function()
  vim.fn.setqflist({}, " ", {
    lines = vim.split(vim.fn.system("pbpaste"), "\n"),
  })
  vim.cmd("copen")
end, { desc = "Quickfix from clipboard" })

