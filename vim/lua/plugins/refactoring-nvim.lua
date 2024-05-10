return {
  "ThePrimeagen/refactoring.nvim",
  lazy = true,
  config = function()
    vim.keymap.set(
      { "v" },
      "<leader>rf",
      ":lua require('jrasmusbm.telescope.refactoring').refactors()<CR>",
      { noremap = true, silent = true }
    )

    require("refactoring").setup()
  end,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    "<leader>rf",
  },
}
