local M = {}

function M.setup(options)
  require("lspconfig").tsserver.setup {
    capabilities = options.capabilities,
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      options.on_attach(client)
    end,
    filetypes = {"typescript", "typescript.express"},
  }
end

return M
