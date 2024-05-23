vim.keymap.set(
  { "n" },
  "<leader>am",
  require("jrasmusbm.treesitter.jump-to-main").main,
  {}
)
