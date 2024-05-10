vim.keymap.set({ "n" }, "<leader>fi", function()
  vim.cmd [[ EnMasse ]]
end, { noremap = true })
