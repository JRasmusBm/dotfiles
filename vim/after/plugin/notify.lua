vim.keymap.set({ "n" }, "<leader><esc>", require("notify").dismiss, {})
vim.keymap.set(
  { "n" },
  "<leader>fm",
  require("telescope").extensions.notify.notify,
  {}
)
