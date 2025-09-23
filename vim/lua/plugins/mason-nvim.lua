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
      handlers = { lua_ls= function() end, efm=function()end }
    })
    require("jrasmusbm.lsp").ensure_setup()
  end,
}
