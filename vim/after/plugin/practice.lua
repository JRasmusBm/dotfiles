vim.api.nvim_create_user_command("VBG", "<cmd>VimBeGood<CR>", { nargs = "*" })

vim.keymap.set({ "n" }, "<leader>ht", "<cmd>Hardtime toggle<CR>", {})
