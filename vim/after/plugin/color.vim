color base16-ia-dark

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

function! HighlightMarker() abort
  highlight SnippetMarker guifg=yellow guibg=NONE
  match SnippetMarker /<++>/
endfunction

function! SpellingHighlights() abort
  highlight SpellBad guifg=teal guibg=NONE 
  highlight SpellCap guifg=teal guibg=NONE 
  highlight SpellLocal guifg=teal guibg=NONE 
  highlight SpellRare guifg=teal guibg=NONE 
endfunction

function! CocHighlights() abort
  highlight CocErrorHighlight guifg=red guibg=NONE gui=undercurl term=undercurl
  highlight CocErrorSign guifg=red guibg=NONE 
  highlight CocWarningHighlight guifg=yellow guibg=NONE gui=undercurl term=undercurl
  highlight CocWarningSign guifg=yellow guibg=NONE 
  highlight CocUnderline gui=undercurl term=undercurl
endfunction

function! ColorCodeHighlights() abort
  lua require'colorizer'.setup()
endfunction


function! CommentHighlights() abort
  execute 'highlight Comment ' . pinnacle#italicize('Comment')
endfunction

call RespectAlacrittyColorscheme()
call FoldHighlights()
call ErrorHighlights()
call SearchHighlights()
call HighlightMarker()
call SpellingHighlights()
call CocHighlights()
call ColorCodeHighlights()
