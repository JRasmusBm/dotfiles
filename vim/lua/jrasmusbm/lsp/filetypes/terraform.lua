local M = {}

M.setup = function(options)
  require("lspconfig").terraformls.setup {
    capabilities = options.capabilities,
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      options.on_attach(client)
    end,
    filetypes = require("jrasmusbm.filetypes").terraform,
  }
end

return M
