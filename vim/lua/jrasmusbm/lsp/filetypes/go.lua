local M = {}

M.setup = function(options)
  require("lspconfig").gopls.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    filetypes = require("jrasmusbm.filetypes").go,
  }
end

return M
