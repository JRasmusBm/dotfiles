vim.keymap.set({ "n" },"]t", "<cmd>tabn", { noremap = true })
vim.keymap.set({ "n" },"[t", "<cmd>tabp", { noremap = true })
vim.keymap.set({ "n" },"<leader>to", '<cmd>exec "tabe " . @%<cr>', { noremap = true })
vim.keymap.set({ "n" },"<leader>tc", "<cmd>tabc<cr>", { noremap = true })
