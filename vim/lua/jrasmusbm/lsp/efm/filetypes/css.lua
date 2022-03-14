local M = {}

M.config = { { formatCommand = "pret --parser=css", formatStdin = true } }

M.filetypes = require("jrasmusbm.filetypes").css

return M
