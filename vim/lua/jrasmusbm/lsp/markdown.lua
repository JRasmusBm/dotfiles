local M = {}

function M.setup(options)
  require('lspconfig').zeta_note.setup{
    on_attach=options.on_attach,
    cmd = {'zeta-note'},
    filetypes = {'markdown'},
}
end

return M
