local M = {}

M.config = {
  {
    formatCommand = "terraform fmt -",
    formatStdin = true,
  },
}

M.filetypes = require("jrasmusbm.filetypes").terraform

return M
