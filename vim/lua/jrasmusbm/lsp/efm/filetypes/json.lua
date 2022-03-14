local M = {}

M.config = { { formatCommand = "pret --parser=json", formatStdin = true } }

M.filetypes = require("jrasmusbm.filetypes").json

return M
