return {
  "stevearc/oil.nvim",
  lazy = true,
  config = function()
    require("oil").setup {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-q>"] = "actions.add_to_qflist",
      },
    }

    vim.keymap.set({ "n" }, "<leader>d", "<cmd>Oil<CR>")
  end,
  keys = { "<leader>d" },
}
