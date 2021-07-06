local M = {}

M.setup = function (options)
  require "lspconfig".efm.setup {
      on_attach = options.on_attach,
      cmd = { "efm-langserver", "-c", vim.fn.stdpath("config") .. "/../efm-langserver/config.yaml" },
      init_options = {
        documentFormatting = true
      }
  }
end

return M
