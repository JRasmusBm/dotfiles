local M = {}

M.setup = function(options)
  require("lspconfig").texlab.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    filetypes = require("jrasmusbm.filetypes").latex,
  }
end

return M
