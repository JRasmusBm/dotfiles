local M = {}

M.config = {
  {formatCommand = "black --quiet -", formatStdin = true}
}

M.filetypes = require("jrasmusbm.filetypes").python

return M
