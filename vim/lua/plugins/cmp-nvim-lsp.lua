return {
  "hrsh7th/cmp-nvim-lsp",
  -- Only its capabilities table is needed at start; it requires cmp
  -- itself on InsertEnter.
  dependencies = {
    "neovim/nvim-lspconfig",
  },
}
