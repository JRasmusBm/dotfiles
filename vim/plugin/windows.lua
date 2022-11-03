vim.opt.splitright = true

vim.keymap.set({ "n" },"<leader>bd", "<cmd>bp! <BAR> bd #<CR>", {})

vim.keymap.set({ "n" },"c<C-j>", "<cmd>bel sp %<cr>", { noremap = true })
vim.keymap.set({ "n" },"c<C-k>", "<cmd>abo sp %<cr>", { noremap = true })
vim.keymap.set({ "n" },"c<C-h>", "<cmd>lefta vsp %<cr>", { noremap = true })
vim.keymap.set({ "n" },"c<C-l>", "<cmd>rightb vsp %<cr>", { noremap = true })
vim.keymap.set({ "n" },"d<C-j>", "<C-w>j<C-w>c", { noremap = true })
vim.keymap.set({ "n" },"d<C-k>", "<C-w>k<C-w>c", { noremap = true })
vim.keymap.set({ "n" },"d<C-h>", "<C-w>h<C-w>c", { noremap = true })
vim.keymap.set({ "n" },"d<C-l>", "<C-w>l<C-w>c", { noremap = true })
vim.keymap.set({ "n" },"o<C-j>", "<cmd>bel sp %<cr><C-w>j<C-w>c", { noremap = true })
vim.keymap.set({ "n" },"o<C-k>", "<cmd>abo sp %<cr><C-w>k<C-w>c", { noremap = true })
vim.keymap.set({ "n" },"o<C-h>", "<cmd>lefta vsp %<cr><C-w>h<C-w>c", { noremap = true })
vim.keymap.set({ "n" },"o<C-l>", "<cmd>rightb vsp %<cr><C-w>l<C-w>c", { noremap = true })
