return {
  "stevearc/oil.nvim",
  lazy = true,
  config = function()
    require("oil").setup()

    vim.keymap.set({ "n" }, "<leader>d", "<cmd>Oil<CR>")
  end,
  keys = { "<leader>d" },
}
