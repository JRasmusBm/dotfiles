local M = {}

M.config = { { formatCommand = "pret --parser=html", formatStdin = true } }

M.filetypes = require("jrasmusbm.filetypes").html

return M
