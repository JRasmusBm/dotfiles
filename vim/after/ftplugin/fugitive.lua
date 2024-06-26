vim.keymap.set({ "n" }, "D", function()
  vim.fn.feedkeys ":DiffviewOpen "
end, { buffer = 0 })

vim.keymap.set({ "n" }, "L", function()
  require("jrasmusbm.git").open_tree()
end, { silent = true, buffer = true })
vim.keymap.set({ "n" }, "q", "q", { noremap = true })

vim.keymap.set({ "n" }, "gh", "<cmd>diffget //2<CR>", { noremap = true })
vim.keymap.set({ "n" }, "gl", "<cmd>diffget //3<CR>", { noremap = true })
