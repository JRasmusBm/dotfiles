vim.keymap.set({ "n" }, "D", function()
  vim.fn.feedkeys ":DiffviewOpen "
end, { buffer = 0 })

vim.keymap.set(
  { "n" },
  "L",
  vim.fn["jrasmusbm#git#open_tree"],
  { silent = true, buffer = true }
)
vim.keymap.set({ "n" }, "q", "q", { noremap = true })
