" Tag
inoremap <buffer> ;tg <<++> />	<++>:call BackwardMarker(2)
" Close Tag
function! CloseTag()
  let save_pos = getpos(".")
  execute "normal! T<yt>f>i <++>/<\/<++>>" . 
        \":call ForwardMarker(1)0"
  call setpos('.', save_pos)
endfunction
inoremap <buffer> ;ct :call CloseTag():call ForwardMarker(1)
inoremap <buffer> ;ot <<++>>	<++></<++>><++>:call BackwardMarker(4)
" Plain Tag Argument
inoremap <buffer> ;ap <++>="<++>" <++>:call BackwardMarker(3)
" JSX Tag Argument
inoremap <buffer> ;aj <++>={<++>} <++>:call BackwardMarker(3)
