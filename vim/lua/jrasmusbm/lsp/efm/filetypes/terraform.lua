local M = {}

M.config = {
    {
        formatCommand = 'terraform fmt -',
        formatStdin = true
    }
}

M.filetypes = {"terraform"}

return M
