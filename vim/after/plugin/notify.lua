vim.keymap.set({ "n" }, "<leader><esc>", function(...)
  return require("notify").dismiss(...)
end, {})
vim.keymap.set(
  { "n" },
  "<leader>fm",
  function()
    require("telescope").extensions.notify.notify()
  end,
  {}
)
