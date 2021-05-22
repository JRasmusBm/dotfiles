local on_attach = require("jrasmusbm.lsp.attach").on_attach

require("jrasmusbm.lsp.lua").setup{ on_attach=on_attach }
require("jrasmusbm.lsp.typescript").setup{ on_attach=on_attach }
