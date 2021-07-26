local M = {}

M.setup = function(options)
  require"lspconfig".efm.setup {
    on_attach = options.on_attach,
    cmd = {
      "efm-langserver", "-c",
      vim.fn.stdpath("config") .. "/../efm-langserver/config.yaml"
    },
    init_options = {documentFormatting = true},
    settings = {
      rootMarkers = {".git/"},
      languages = {
        bash = require("jrasmusbm.lsp.efm.bash"),
        css = require("jrasmusbm.lsp.efm.css"),
        html = require("jrasmusbm.lsp.efm.html"),
        init = require("jrasmusbm.lsp.efm.init"),
        javascript = require("jrasmusbm.lsp.efm.javascript"),
        json = require("jrasmusbm.lsp.efm.json"),
        lua = require("jrasmusbm.lsp.efm.lua"),
        markdown = require("jrasmusbm.lsp.efm.markdown"),
        python = require("jrasmusbm.lsp.efm.python"),
        sh = require("jrasmusbm.lsp.efm.sh"),
        typescript = require("jrasmusbm.lsp.efm.typescript"),
        zsh = require("jrasmusbm.lsp.efm.zsh"),
      }
    }
  }
end

return M
