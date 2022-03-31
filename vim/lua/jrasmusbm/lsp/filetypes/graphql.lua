local M = {}

M.setup = function()
  local filetypes = require("jrasmusbm.filetypes").graphql

  for _, filetype in ipairs(require("jrasmusbm.filetypes").javascript) do
    table.insert(filetypes, filetype)
  end

  for _, filetype in ipairs(require("jrasmusbm.filetypes").typescript) do
    table.insert(filetypes, filetype)
  end

  require("lspconfig").graphql.setup {
    filetypes = filetypes,
  }
end

return M
