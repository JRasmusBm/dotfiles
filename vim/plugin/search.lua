vim.keymap.set({ "n" }, "gs", ':%s/<c-r>=expand("<cword>")<cr>/')

vim.keymap.set({ "n" }, "<Leader> fc", "<cmd>Cheat<CR>", { noremap = true })
