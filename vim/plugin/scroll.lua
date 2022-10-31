require("jrasmusbm.utils").ensure_setup "vim-smoothie"

vim.g.smoothie_update_interval = 20
vim.g.smoothie_speed_constant_factor = 20
vim.g.smoothie_speed_linear_factor = 20
vim.g.smoothie_speed_exponentiation_factor = 0.95

vim.keymap.set({ "n" }, "<C-O>", "<C-O>zz", { noremap = true })
vim.keymap.set({ "n" }, "<C-I>", "<C-I>zz", { noremap = true })

vim.keymap.set({ "n", "v" }, "n", "nzzzv", { noremap = true })
vim.keymap.set({ "n", "v" }, "N", "Nzzzv", { noremap = true })
