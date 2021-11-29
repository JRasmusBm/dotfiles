local M = {}

function M.setup(options)
  local filetypes = require("jrasmusbm.filetypes").typescript
  for _, filetype in ipairs(require("jrasmusbm.filetypes").javascript) do
    table.insert(filetypes, filetype)
  end
  require("lspconfig").tsserver.setup {
    capabilities = options.capabilities,
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      options.on_attach(client)
    end,
    filetypes = filetypes,
  }
end

return M
