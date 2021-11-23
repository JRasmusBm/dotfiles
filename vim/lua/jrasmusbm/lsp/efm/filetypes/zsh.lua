local M = {}

M.config = {
    {
        formatCommand = 'shfmt -s -ci -bn -i=2',
        formatStdin = true
    }
}

M.filetypes = {"zsh"}

return M
