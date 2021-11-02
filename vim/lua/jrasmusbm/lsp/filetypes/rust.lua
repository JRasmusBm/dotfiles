local M = {}

M.setup = function(options)
  require("lspconfig").rls.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    settings = {
      rust = {
        unstable_features = true,
        build_on_save = false,
        all_features = true,
      },
    },
  }
end

return M
