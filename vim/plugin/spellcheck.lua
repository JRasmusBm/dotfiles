vim.keymap.set({ "n" },
  "<leader>ce",
  "<cmd>set spell spelllang+=en_us,<CR>",
  { noremap = true }
)
vim.keymap.set({ "n" },
  "<leader>cv",
  "<cmd>set spell spelllang+=sv,<CR>",
  { noremap = true }
)
vim.keymap.set({ "n" },
  "<leader>cd",
  "<cmd>set spell spelllang+=de,<CR>",
  { noremap = true }
)
vim.keymap.set({ "n" },
  "<leader>cn",
  "<cmd>set spell spelllang+=nl,<CR>",
  { noremap = true }
)
vim.keymap.set({ "n" },"<leader>ci", "<cmd>set invspell<CR>", { noremap = true })
vim.keymap.set({ "n" },"<leader>cc", '<cmd>set spelllang=""<CR>', { noremap = true })
