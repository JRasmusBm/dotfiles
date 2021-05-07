color base16-ia-dark

function! CustomMarkers() abort
  highlight SnippetMarker guifg=yellow guibg=NONE
  highlight TODOMarker guifg=#FF87AF guibg=NONE
  match TODOMarker /TODO/
  match SnippetMarker /<++>/
endfunction

function! RulerHighlights() abort
  highlight CursorColumn guibg=#303000
  highlight CursorLine guibg=#303000
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

function! CocHighlights() abort
  highlight CocErrorHighlight guibg=NONE gui=undercurl term=undercurl
  highlight CocErrorSign guifg=red guibg=NONE 
  highlight CocWarningHighlight guibg=NONE gui=undercurl term=undercurl
  highlight CocWarningSign guifg=yellow guibg=NONE 
  highlight CocInfoHighlight guibg=NONE gui=undercurl term=undercurl
  highlight CocInfoSign guifg=white guibg=NONE 
  highlight CocHintHighlight guibg=NONE gui=undercurl term=undercurl
  highlight CocHintSign guifg=white guibg=NONE 
  highlight CocUnderline gui=undercurl term=undercurl
endfunction

function! ColorCodeHighlights() abort
  lua require'colorizer'.setup()
endfunction

function! CommentHighlights() abort
  execute 'highlight Comment ' . pinnacle#italicize('Comment')
endfunction

call RespectAlacrittyColorscheme()
call DiffHighlights()
call FoldHighlights()
call ErrorHighlights()
call SearchHighlights()
call SpellingHighlights()
call CocHighlights()
call ColorCodeHighlights()
call CustomMarkers()
call RulerHighlights()
