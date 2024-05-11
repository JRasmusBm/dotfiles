return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_char = "│"
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
