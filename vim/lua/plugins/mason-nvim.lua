return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      automatic_enable = false,
      handlers = { lua_ls= function() end, efm=function()end }
    })
    require("jrasmusbm.lsp").ensure_setup()
  end,
}
