highlight SnippetMarker ctermfg=yellow guifg=yellow
match SnippetMarker /<++>/

" Helper Functions {{{
function! BackwardMarker(n)
  if a:n > 0
    execute 'normal! ?<++> '  . a:n . 'n"'
  else
    execute 'normal! ?<++>"'
  endif
  if ColumnFromRight() == 4
    normal "_dgn
    execute 'startinsert!'
  else
    normal "_dgn
    execute 'startinsert'
  endif
endfunction

function! ForwardMarker(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n"'
  else
    execute 'normal! /<++>"'
  endif
  if ColumnFromRight() == 4
    normal "_dgn
    execute 'startinsert!'
  else
    normal "_dgn
    execute 'startinsert'
  endif
endfunction

function! DeleteAllMarkers()
  let save_pos = getpos('.')
  execute '%s/<++>//g'
  call setpos('.', save_pos)
endfunction

function! DeleteMarker(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n"'
  else
    execute 'normal! /<++>"'
  endif
endfunction

function! DeleteMarkerRow(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n"_dd'
  else
    execute 'normal! /<++>"_dd'
  endif
endfunction
" }}}

function! ColumnFromRight() abort
  let cur_pos = getpos('.')
  normal! $
  let last_col = col('.')
  call setpos('.', cur_pos)
  return last_col + 1 - cur_pos[2]
endfunction

inoremap <leader><leader> <++>
inoremap <leader>dd :call DeleteMarkerRow(1)
inoremap <leader>da :call DeleteAllMarkers()
inoremap <leader>dm :call DeleteMarker(1)
nnoremap <leader>dd :call DeleteMarkerRow(1)
nnoremap <leader>da :call DeleteAllMarkers()
nnoremap <leader>dm :call DeleteMarker(1)
inoremap <leader>G :call BackwardMarker(1)
nnoremap <Leader>G :call BackwardMarker(1)
nnoremap 2<Leader>G :call BackwardMarker(2)
nnoremap 3<Leader>G :call BackwardMarker(3)
nnoremap 4<Leader>G :call BackwardMarker(4)
nnoremap 5<Leader>G :call BackwardMarker(5)
nnoremap 6<Leader>G :call BackwardMarker(6)
inoremap <leader>g :call ForwardMarker(1)
inoremap 2<leader>g :call ForwardMarker(2)
inoremap 3<leader>g :call ForwardMarker(3)
inoremap 4<leader>g :call ForwardMarker(4)
inoremap 5<leader>g :call ForwardMarker(5)
inoremap 6<leader>g :call ForwardMarker(6)
nnoremap <Leader>g :call ForwardMarker(1)
nnoremap 2<Leader>g :call ForwardMarker(2)
nnoremap 3<Leader>g :call ForwardMarker(3)
nnoremap 4<Leader>g :call ForwardMarker(4)
nnoremap 5<Leader>g :call ForwardMarker(5)
nnoremap 6<Leader>g :call ForwardMarker(6)
inoremap <leader>cp :call ForwardMarker(1).:call ForwardMarker(1)
