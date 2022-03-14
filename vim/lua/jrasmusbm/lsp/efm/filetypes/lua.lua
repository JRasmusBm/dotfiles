local M = {}

M.config = {
  {
    formatCommand = "stylua -",
    formatStdin = true,
  },
}

M.filetypes = require("jrasmusbm.filetypes").lua

return M
