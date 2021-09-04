local M = {}

M.setup = function (options)
  require'lspconfig'.texlab.setup{
    on_attach=options.on_attach
  }
end

return M
