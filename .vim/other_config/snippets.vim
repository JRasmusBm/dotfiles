highlight GoToMarker ctermfg=yellow guifg=yellow
match GoToMarker /<++>/
nnoremap <Leader>es :Files ~/.vim/snippets/<CR>

" Helper Functions {{{
function! BackwardMarker(n)
  if a:n > 0
    execute 'normal! ?<++> '  . a:n . 'n"_d4l'
  else
    execute 'normal! ?<++>"_d4l'
  endif
  execute 'startinsert'
endfunction
function! ForwardMarker(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n"_4x'
  else
    execute 'normal! /<++>"_4x'
  endif
  execute 'startinsert'
endfunction
function! DeleteAllMarkers()
  let save_pos = getpos('.')
  execute '%s/<++>//g'
  call setpos('.', save_pos)
endfunction
function! DeleteMarker(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n"_d4l'
  else
    execute 'normal! /<++>"_d4l'
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


inoremap ;; <++>
inoremap ;dd :call DeleteMarkerRow(1)
inoremap ;da :call DeleteAllMarkers()
inoremap ;dm :call DeleteMarker(1)
nnoremap ;dd :call DeleteMarkerRow(1)
nnoremap ;da :call DeleteAllMarkers()
nnoremap ;dm :call DeleteMarker(1)
inoremap ;G :call BackwardMarker(1)
nnoremap <Leader>G :call BackwardMarker(1)
nnoremap 2<Leader>G :call BackwardMarker(2)
nnoremap 3<Leader>G :call BackwardMarker(3)
nnoremap 4<Leader>G :call BackwardMarker(4)
nnoremap 5<Leader>G :call BackwardMarker(5)
nnoremap 6<Leader>G :call BackwardMarker(6)
inoremap ;g :call ForwardMarker(1)
inoremap 2;g :call ForwardMarker(2)
inoremap 3;g :call ForwardMarker(3)
inoremap 4;g :call ForwardMarker(4)
inoremap 5;g :call ForwardMarker(5)
inoremap 6;g :call ForwardMarker(6)
nnoremap <Leader>g :call ForwardMarker(1)
nnoremap 2<Leader>g :call ForwardMarker(2)
nnoremap 3<Leader>g :call ForwardMarker(3)
nnoremap 4<Leader>g :call ForwardMarker(4)
nnoremap 5<Leader>g :call ForwardMarker(5)
nnoremap 6<Leader>g :call ForwardMarker(6)
