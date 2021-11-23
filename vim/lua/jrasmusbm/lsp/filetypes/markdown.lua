local M = {}

function M.setup(options)
  require("lspconfig").zeta_note.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    cmd = {"zeta-note"},
    filetypes = require("jrasmusbm.filetypes").markdown,
  }
end

return M
