packadd! nvim-lspconfig
packadd! nvim-lsp-diamove

sign define LspDiagnosticsErrorSign text=✗ texthl=LspDiagnosticsError
sign define LspDiagnosticsWarningSign text=⚠ texthl=LspDiagnosticsWarning
sign define LspDiagnosticsInformationSign text=i texthl=LspDiagnosticsInformation
sign define LspDiagnosticsHintSign text=※ texthl=LspDiagnosticsHint

augroup LspLocationList
  autocmd User LspDiagnosticsChanged lua vim.lsp.diagnostic.set_loclist({ open_loclist=false })
augroup END

let g:lsp_diamove_disable_default_mapping=1
