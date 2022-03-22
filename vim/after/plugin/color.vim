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
  highlight ColorColumn guibg=#472322
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
  highlight link SpelunkerSpellBad SpellBad
  highlight link SpelunkerComplexOrCompoundWord SpellRare
endfunction

function! IlluminateHighlights() abort
  highlight def LspReferenceText link CursorLine
  highlight def LspReferenceWrite link CursorLine
  highlight def LspReferenceRead link CursorLine
  highlight def illuminatedWord link CursorLine
endfunction

function! DiagnosticHighlight() abort
  highlight DiagnosticVirtualTextError guifg=red
  sign define DiagnosticSignError text=✗ texthl=DiagnosticSignError linehl= numhl=
  highlight DiagnosticSignError guifg=red

  highlight DiagnosticVirtualTextWarn guifg=yellow
  sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=
  highlight DiagnosticSignWarn guifg=yellow

  highlight DiagnosticVirtualTextInfo guifg=teal
  sign define DiagnosticSignInfo text=i texthl=DiagnosticSignInfo linehl= numhl=
  highlight DiagnosticSignInfo guifg=teal

  highlight DiagnosticVirtualTextHint guifg=pink
  sign define DiagnosticSignHint text=☼ texthl=DiagnosticSignHint linehl= numhl=
  highlight DiagnosticSignHint guifg=pink
endfunction

function! DapHighlight() abort
  highlight debugPC guifg=#282828 guibg=#a9b665
  sign define DapBreakpoint text=🔴 texthl= linehl= numhl=
  sign define DapBreakpointCondition text=🟡 texthl= linehl= numhl=
  sign define DapStopped text=🐛 texthl= linehl=debugPC numhl=
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
call DiagnosticHighlight()
call ColorCodeHighlights()
call CustomMarkers()
call RulerHighlights()
call IlluminateHighlights()
call DapHighlight()
