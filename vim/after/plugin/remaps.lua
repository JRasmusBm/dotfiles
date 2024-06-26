vim.keymap.set({ "i" }, "<C-h>", "<Esc>", { noremap = true })
vim.keymap.set({ "i" }, "<C-c>", "<Esc>", { noremap = true })
vim.keymap.set({ "n" }, "Q", "<nop>")
vim.keymap.set({ "n" }, "gQ", "qqVipJ2jq2{w0")

vim.keymap.set({ "n" }, "go", "o<Esc>S", { noremap = true })
vim.keymap.set({ "n" }, "gO", "O<Esc>S", { noremap = true })

vim.keymap.set(
  { "n" },
  "<leader>qo",
  "<cmd>copen<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set(
  { "n" },
  "<leader>qc",
  "<cmd>cclose<cr>",
  { silent = true, noremap = true }
)

vim.keymap.set(
  { "n" },
  "H",
  "<cmd>cprev<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set(
  { "n" },
  "L",
  "<cmd>cnext<cr>",
  { silent = true, noremap = true }
)

vim.keymap.set(
  { "n" },
  "<leader>lo",
  "<cmd>lopen<cr>",
  { silent = true, noremap = true }
)
vim.keymap.set(
  { "n" },
  "<leader>lc",
  "<cmd>lclose<cr>",
  { silent = true, noremap = true }
)
