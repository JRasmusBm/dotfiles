local M = {}

M.config = {
  {formatCommand = "black --quiet -", formatStdin = true}
}

M.filetypes = {"python", "python.unittest"}

return M
