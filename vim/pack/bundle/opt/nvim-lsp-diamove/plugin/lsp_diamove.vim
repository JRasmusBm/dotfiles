command! -count=1 Dabove lua require'lsp_diamove'.jump_above(<count>)
command! -count=1 Dbelow lua require'lsp_diamove'.jump_below(<count>)

if !get(g:, 'lsp_diamove_disable_default_mapping', v:false)
  noremap <expr> [d '<cmd>' . v:count1 . 'Dabove<CR>'
  noremap <expr> ]d '<cmd>' . v:count1 . 'Dbelow<CR>'
endif
