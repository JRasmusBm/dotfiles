local M = {}

M.setup = function(options)
  require("lspconfig").rust_analyzer.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    filetypes = require("jrasmusbm.filetypes").rust,
    cmd={"rustup", "run", "stable", "rust-analyzer"}
  }
end

return M
