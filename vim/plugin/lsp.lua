vim.cmd [[
packadd nvim-lspconfig

sign define DiagnosticErrorSign text=✗ texthl=DiagnosticError
sign define DiagnosticWarningSign text=⚠ texthl=DiagnosticWarning
sign define DiagnosticInformationSign text=i texthl=DiagnosticInformation
sign define DiagnosticHintSign text=※ texthl=DiagnosticHint

augroup LspLocationList
  autocmd User DiagnosticChanged lua vim.diagnostic.setloclist({ open=false })
augroup END
]]
