return {
  "stevearc/oil.nvim",
  lazy = true,
  config = function()
    require("oil").setup {
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set({ "n" }, "<leader>d", "<cmd>Oil<CR>")
  end,
  keys = { "<leader>d" },
}
