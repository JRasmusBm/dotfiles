packadd! nvim-lspconfig
packadd! nvim-lsp-diamove

sign define LspDiagnosticsErrorSign text=✗ texthl=LspDiagnosticsError
sign define LspDiagnosticsWarningSign text=⚠ texthl=LspDiagnosticsWarning
sign define LspDiagnosticsInformationSign text=i texthl=LspDiagnosticsInformation
sign define LspDiagnosticsHintSign text=※ texthl=LspDiagnosticsHint

let g:lsp_diamove_disable_default_mapping=1

nnoremap     :lua vim.lsp.buf.definition()<CR>
nnoremap K     :lua vim.lsp.buf.hover()<CR>
nnoremap gD    :lua vim.lsp.buf.implementation()<CR>
nnoremap     :lua vim.lsp.buf.signature_help()<CR>
nnoremap gt   :lua vim.lsp.buf.type_definition()<CR>
nnoremap gr    :lua vim.lsp.buf.references()<CR>
nnoremap g0    :lua vim.lsp.buf.document_symbol()<CR>
nnoremap gW    :lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap gd    :lua vim.lsp.buf.declaration()<CR>

noremap <expr> [v '<cmd>' . v:count1 . 'Dabove<CR>'
noremap <expr> ]v '<cmd>' . v:count1 . 'Dbelow<CR>'

lua require'nvim_lsp'.tsserver.setup{}
