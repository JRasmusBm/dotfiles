function! jrasmusbm#colors#show_highlight() abort
    let name = 'hi<' . synIDattr(synID(line("."),col("."),1),"name") . '>' 
    let trans =  'trans<' . synIDattr(synID(line("."),col("."),0),"name") . '>'
    let location = 'lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . '>'
    echo name . ' ' . trans . ' ' . location
endfunction

function! jrasmusbm#colors#custom_markers() abort
  highlight SnippetMarker guifg=yellow guibg=NONE
  highlight TODOMarker guifg=#FF87AF guibg=NONE
  match TODOMarker /TODO/
  match SnippetMarker /<++>/
endfunction

function! jrasmusbm#colors#ruler_highlights() abort
  highlight CursorColumn guibg=#3a3a00
  highlight CursorLine guibg=#3a3a00
  highlight ColorColumn guibg=#472322
endfunction

function! jrasmusbm#colors#respect_alacritty_colorscheme() abort
  highlight! Normal ctermbg=NONE guibg=NONE
  highlight! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
endfunction

function! jrasmusbm#colors#fold_highlights() abort
  highlight Folded guibg=NONE guifg=darkyellow
  highlight FoldColumn guibg=darkgrey guifg=white
endfunction

function! jrasmusbm#colors#error_highlights() abort
  highlight Error guifg=red guibg=NONE
  highlight BadWhitespace guibg=darkred
endfunction

function! jrasmusbm#colors#search_highlights() abort
  highlight Search guifg=yellow guibg=NONE
endfunction

function! jrasmusbm#colors#diff_highlights() abort
  highlight DiffAdd guifg=None guibg=#003300
  highlight DiffChange guifg=None guibg=#002020
  highlight DiffText guifg=None guibg=#353500
  highlight DiffDelete guifg=None guibg=#500000
endfunction

function! jrasmusbm#colors#spelling_highlights() abort
  highlight SpellBad guifg=teal guibg=NONE 
  highlight SpellCap guifg=teal guibg=NONE 
  highlight SpellLocal guifg=teal guibg=NONE 
  highlight SpellRare guifg=teal guibg=NONE 
  highlight link SpelunkerSpellBad SpellBad
  highlight link SpelunkerComplexOrCompoundWord SpellRare
endfunction

function! jrasmusbm#colors#illuminate_highlights() abort
  highlight def LspReferenceText link CursorLine
  highlight def LspReferenceWrite link CursorLine
  highlight def LspReferenceRead link CursorLine
  highlight def illuminatedWord link CursorLine
endfunction

function! jrasmusbm#colors#lsp_highlights() abort
  highlight LspDiagnosticsVirtualTextError guifg=red
  sign define LspDiagnosticsSignError text=✗ texthl=LspDiagnosticsSignError linehl= numhl=
  highlight LspDiagnosticsSignError guifg=red

  highlight LspDiagnosticsVirtualTextWarning guifg=yellow
  sign define LspDiagnosticsSignWarning text=⚠ texthl=LspDiagnosticsSignWarning linehl= numhl=
  highlight LspDiagnosticsSignWarning guifg=yellow

  highlight LspDiagnosticsVirtualTextInformation guifg=teal
  sign define LspDiagnosticsSignInformation text=i texthl=LspDiagnosticsSignInformation linehl= numhl=
  highlight LspDiagnosticsSignInformation guifg=teal

  highlight LspDiagnosticsVirtualTextHint guifg=pink
  sign define LspDiagnosticsSignHint text=☼ texthl=LspDiagnosticsSignHint linehl= numhl=
  highlight LspDiagnosticsSignHint guifg=pink
endfunction

function! jrasmusbm#colors#color_code_highlights() abort
  lua require'colorizer'.setup()
endfunction

function! jrasmusbm#colors#comment_highlights() abort
  execute 'highlight Comment ' . pinnacle#italicize('Comment')
endfunction

function! jrasmusbm#colors#notify_highlights() abort
  highlight NotifyBackground guifg=#32302f guibg=#32302f

  highlight NotifyERRORBorder guifg=#ea6962 guibg=#32302f
  highlight NotifyERRORIcon guifg=#ea6962 guibg=#32302f
  highlight NotifyERRORTitle  guifg=#ea6962 guibg=#32302f
  highlight NotifyERRORBody guifg=#d4be98  guibg=#32302f

  highlight NotifyWARNBorder guifg=#D8A657 guibg=#32302f
  highlight NotifyWARNIcon guifg=#D8A657 guibg=#32302f
  highlight NotifyWARNTitle guifg=#D8A657 guibg=#32302f
  highlight NotifyWARNBody guifg=#d4be98 guibg=#32302f

  highlight NotifyINFOBorder guifg=#89B482 guibg=#32302f
  highlight NotifyINFOIcon guifg=#89B482 guibg=#32302f
  highlight NotifyINFOTitle guifg=#89B482 guibg=#32302f
  highlight NotifyINFOBody guifg=#d4be98 guibg=#32302f

  highlight NotifyDEBUGBorder guifg=#D4BE98 guibg=#32302f
  highlight NotifyDEBUGIcon guifg=#D4BE98 guibg=#32302f
  highlight NotifyDEBUGTitle  guifg=#D4BE98 guibg=#32302f
  highlight NotifyDEBUGBody guifg=#d4be98 guibg=#32302f

  highlight NotifyTRACEBorder guifg=#89B482 guibg=#32302f
  highlight NotifyTRACEIcon guifg=#89B482 guibg=#32302f
  highlight NotifyTRACETitle  guifg=#89B482 guibg=#32302f
  highlight NotifyTRACEBody guifg=#d4be98 guibg=#32302f
endfunction

function! jrasmusbm#colors#update_highlights() abort
  call jrasmusbm#colors#respect_alacritty_colorscheme()
  call jrasmusbm#colors#diff_highlights()
  call jrasmusbm#colors#fold_highlights()
  call jrasmusbm#colors#error_highlights()
  call jrasmusbm#colors#search_highlights()
  call jrasmusbm#colors#spelling_highlights()
  call jrasmusbm#colors#lsp_highlights()
  call jrasmusbm#colors#color_code_highlights()
  call jrasmusbm#colors#custom_markers()
  call jrasmusbm#colors#ruler_highlights()
  call jrasmusbm#colors#illuminate_highlights()
  call jrasmusbm#colors#notify_highlights()
endfunction
