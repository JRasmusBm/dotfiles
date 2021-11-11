vim.cmd [[
packadd! nvim-lspconfig

sign define LspDiagnosticsErrorSign text=✗ texthl=LspDiagnosticsError
sign define LspDiagnosticsWarningSign text=⚠ texthl=LspDiagnosticsWarning
sign define LspDiagnosticsInformationSign text=i texthl=LspDiagnosticsInformation
sign define LspDiagnosticsHintSign text=※ texthl=LspDiagnosticsHint

augroup LspLocationList
  autocmd User LspDiagnosticsChanged lua vim.diagnostic.setloclist({ open=false })
augroup END
]]
