return {
  "neovim/nvim-lspconfig",
  config = function()
    require("jrasmusbm.lsp").ensure_setup()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
