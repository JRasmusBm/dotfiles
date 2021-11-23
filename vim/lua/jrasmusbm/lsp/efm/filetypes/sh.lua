local M = {}

M.config = {
  {
    lintCommand = "shellcheck -f gcc -x",
    lintSource = "shellcheck",
    lintFormats = {
      "%f:%l:%c: %trror: %m",
      "%f:%l:%c: %tarning: %m",
      "%f:%l:%c: %tote: %m",
    },
    formatCommand = "shfmt -s -ci -bn -i=2",
    formatStdin = true,
  },
}

M.filetypes = require("jrasmusbm.filetypes").sh

return M
