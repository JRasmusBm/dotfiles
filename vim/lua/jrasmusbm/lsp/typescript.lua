local M = {}

function M.setup(options)
  require('lspconfig').tsserver.setup{ on_attach=options.on_attach }
end

return M
