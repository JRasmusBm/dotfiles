local M = {}

M.setup = function(options)
  require"lspconfig".terraformls.setup {
    capabilities = options.capabilities,
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      options.on_attach(client)
    end,
    filetypes = {"terraform"},
  }
end

return M
