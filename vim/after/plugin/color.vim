let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[40;2;%lu;%lu;%lum"

let g:gruvbox_material_palette = 'material'
colorscheme gruvbox-material

function! CustomMarkers() abort
  highlight SnippetMarker guifg=yellow guibg=NONE
  highlight TODOMarker guifg=#FF87AF guibg=NONE
  match TODOMarker /TODO/
  match SnippetMarker /<++>/
endfunction

function! RulerHighlights() abort
  highlight CursorColumn guibg=#3a3a00
  highlight CursorLine guibg=#3a3a00
endfunction

function! RespectAlacrittyColorscheme() abort
  highlight! Normal ctermbg=NONE guibg=NONE
  highlight! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
endfunction

function! FoldHighlights() abort
  highlight Folded guibg=NONE guifg=darkyellow
  highlight FoldColumn guibg=darkgrey guifg=white
endfunction

function! ErrorHighlights() abort
  highlight Error guifg=red guibg=NONE
  highlight BadWhitespace guibg=darkred
endfunction

function! SearchHighlights() abort
  highlight Search guifg=yellow guibg=NONE
endfunction

function! DiffHighlights() abort
  highlight DiffAdd guifg=None guibg=#003300
  highlight DiffChange guifg=None guibg=#002020
  highlight DiffText guifg=None guibg=#353500
  highlight DiffDelete guifg=None guibg=#500000
endfunction

function! SpellingHighlights() abort
  highlight SpellBad guifg=teal guibg=NONE 
  highlight SpellCap guifg=teal guibg=NONE 
  highlight SpellLocal guifg=teal guibg=NONE 
  highlight SpellRare guifg=teal guibg=NONE 
endfunction

function! LspHighlights() abort
  highlight LspDiagnosticsDefaultError guifg=red
  sign define LspDiagnosticsSignError text=✗ texthl=LspDiagnosticsSignError linehl= numhl=
  highlight LspDiagnosticsSignError guifg=red

  highlight LspDiagnosticsDefaultWarning guifg=yellow
  sign define LspDiagnosticsSignWarning text=⚠ texthl=LspDiagnosticsSignWarning linehl= numhl=
  highlight LspDiagnosticsSignWarning guifg=yellow

  highlight LspDiagnosticsDefaultInformation guifg=yellow
  sign define LspDiagnosticsSignInformation text=i texthl=LspDiagnosticsSignInformation linehl= numhl=
  highlight LspDiagnosticsSignInformation guifg=fg0

  highlight LspDiagnosticsDefaultHint guifg=yellow
  sign define LspDiagnosticsSignHint text=☼ texthl=LspDiagnosticsSignHint linehl= numhl=
  highlight LspDiagnosticsSignHint guifg=fg0
endfunction

function! ColorCodeHighlights() abort
  lua require'colorizer'.setup()
endfunction

function! CommentHighlights() abort
  execute 'highlight Comment ' . pinnacle#italicize('Comment')
endfunction

lua require("jrasmusbm.statusline").setup()

call RespectAlacrittyColorscheme()
call DiffHighlights()
call FoldHighlights()
call ErrorHighlights()
call SearchHighlights()
call SpellingHighlights()
call LspHighlights()
call ColorCodeHighlights()
call CustomMarkers()
call RulerHighlights()
