local M = {}

M.config = {
    {
        formatCommand = 'shfmt -s -ci -bn -i=2',
        formatStdin = true
    }
}

M.filetypes = require("jrasmusbm.filetypes").zsh

return M
