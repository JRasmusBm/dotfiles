vim.keymap.set({ "n" }, "gs", ":%s//g<Left><Left>")
vim.keymap.set({ "v" }, "gs", ":s//g<Left><Left>")

vim.keymap.set({ "n" }, "<Leader> fc", "<cmd>Cheat<CR>", { noremap = true })
vim.keymap.set({ "c" }, "<c-j>", "{-}", { noremap = true })
