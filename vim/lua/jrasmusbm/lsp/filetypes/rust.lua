local M = {}

local cmd = {"rustup", "run", "stable", "rust-analyzer"}

if require("jrasmusbm.compat").in_termux() then
  cmd = {"rust-analyzer"}
end

M.setup = function(options)
  require("lspconfig").rust_analyzer.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    filetypes = require("jrasmusbm.filetypes").rust,
    cmd=cmd
  }
end

return M
