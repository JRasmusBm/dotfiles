local M = {}

M.setup = function(options)
  require"lspconfig".texlab.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
  }
end

return M
