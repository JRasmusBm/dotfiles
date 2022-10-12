let g:gruvbox_material_palette = 'material'
colorscheme gruvbox-material

function! CustomMarkers() abort
  match TODOMarker /TODO/
  match SnippetMarker /<++>/
  highlight SnippetMarker guifg=yellow guibg=NONE
  highlight TODOMarker guifg=#FF87AF guibg=NONE
endfunction

function! RulerHighlights() abort
  highlight CursorColumn guibg=#303000
  highlight CursorLine guibg=#303000 " TODO
  highlight ColorColumn guibg=#301810
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
  highlight DiffAdd guifg=None guibg='#1f5816'
  highlight DiffChange guifg=None guibg=None
  highlight DiffText guifg=None guibg='#353500'
  highlight DiffDelete guifg=None guibg='#440000'
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

function! UpdateHighlights() abort
  lua vim.opt.background=require("jrasmusbm.theme").get_current_theme()

  call RespectAlacrittyColorscheme()
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
  call DiffHighlights()
endfunction

call UpdateHighlights()
augroup UpdateJRasmusBmTheme
  autocmd!
  autocmd FocusGained * call UpdateHighlights()
augroup END



