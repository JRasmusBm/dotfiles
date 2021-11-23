local Path = require("plenary.path")

local M = {}

M.config = {
  {
    formatCommand = "lua-format -c " .. Path:new("~/.lua-format.yaml"):expand() ..
      " -i",
    formatStdin = true,
  },
}

M.filetypes = require("jrasmusbm.filetypes").lua

return M
