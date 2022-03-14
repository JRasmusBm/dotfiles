local M = {}

M.config = { { formatCommand = "pret --parser=markdown", formatStdin = true } }

M.filetypes = require("jrasmusbm.filetypes").markdown

return M
