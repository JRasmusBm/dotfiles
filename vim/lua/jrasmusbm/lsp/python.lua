local M = {}

function M.setup(options)
  require'lspconfig'.pyls_ms.setup{
    on_attach=options.on_attach,
    cmd = {
      "dotnet",
      "exec",
      "~/.cache/python-language-server/output/bin/Debug/Microsoft.Python.LanguageServer.dll"
    },
    filetypes = { "python" },
    init_options = {
      analysisUpdates = true,
      asyncStartup = true,
      displayOptions = {},
      interpreter = {
        properties = {
          InterpreterPath = "",
          Version = ""
        },
      },
    },
    settings = {
      python = {
        analysis = {
          disabled = {},
          errors = {},
          info = {},
        },
      },
    },
  }
end

return M
