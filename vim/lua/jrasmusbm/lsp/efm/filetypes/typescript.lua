local M = {}

M.config = {{formatCommand = 'pret --parser=typescript', formatStdin = true}}

M.filetypes = require("jrasmusbm.filetypes").typescript

return M
