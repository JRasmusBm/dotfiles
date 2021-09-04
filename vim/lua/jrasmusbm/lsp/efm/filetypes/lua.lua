local Path = require("plenary.path")

return {
  {
    formatCommand = "lua-format -c " .. Path:new("~/.lua-format.yaml"):expand() ..
      " -i",
    formatStdin = true,
  },
}
