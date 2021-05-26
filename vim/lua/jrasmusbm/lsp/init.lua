local on_attach = require("jrasmusbm.lsp.attach").on_attach

require("jrasmusbm.lsp.completion").setup{}

require("jrasmusbm.lsp.lua").setup{ on_attach=on_attach }
require("jrasmusbm.lsp.typescript").setup{ on_attach=on_attach }
require("jrasmusbm.lsp.python").setup{ on_attach=on_attach }
require("jrasmusbm.lsp.markdown").setup{ on_attach=on_attach }
