local M = {}

M.config = { { formatCommand = "pret --parser=babel", formatStdin = true } }

M.filetypes = require("jrasmusbm.filetypes").javascript

return M
