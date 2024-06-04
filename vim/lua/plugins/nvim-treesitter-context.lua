return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup {
      multiline_threshold = 1,
    }
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
