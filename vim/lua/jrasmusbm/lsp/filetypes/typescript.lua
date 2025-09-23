local M = {}

function M.setup(options)
  local filetypes = require("jrasmusbm.filetypes").typescript
  for _, filetype in ipairs(require("jrasmusbm.filetypes").javascript) do
    table.insert(filetypes, filetype)
  end
  require("lspconfig").ts_ls.setup {
    root_dir = function(fname)
      return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
    single_file_support = false,
    capabilities = options.capabilities,
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      options.on_attach(client)
    end,
    filetypes = filetypes,
  }
  require("lspconfig").eslint.setup {
    filetypes = filetypes,
  }
end

return M
