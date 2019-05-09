" Tag
inoremap <buffer> ;tt <<++> />	<++>:call BackwardMarker(2)
" Close Tag
function! CloseTag()
  let save_pos = getpos(".")
  execute "normal! T<yt>f>i <++>/<\/<++>>" . 
        \":call ForwardMarker(1)0"
  call setpos('.', save_pos)
endfunction
inoremap <buffer> ;tc :call CloseTag():call ForwardMarker(1)
inoremap <buffer> ;td <div><++></div>o<++>:call BackwardMarker(2)
inoremap <buffer> ;h1 <h1><++></h1>o<++>:call BackwardMarker(2)
inoremap <buffer> ;h2 <h2><++></h2>o<++>:call BackwardMarker(2)
inoremap <buffer> ;h3 <h3><++></h3>o<++>:call BackwardMarker(2)
inoremap <buffer> ;h4 <h4><++></h4>o<++>:call BackwardMarker(2)
inoremap <buffer> ;h5 <h5><++></h5>o<++>:call BackwardMarker(2)
inoremap <buffer> ;h6 <h6><++></h6>o<++>:call BackwardMarker(2)
inoremap <buffer> ;to <<++>>	<++></<++>><<o<++>:call BackwardMarker(4)
" String Tag Argument
inoremap <buffer> ;as <++>="<++>" <++>:call BackwardMarker(3)
" JSX Tag Argument
inoremap <buffer> ;aj <++>={<++>} <++>:call BackwardMarker(3)
inoremap <buffer> ;hf <!DOCTYPE html><html>	<head>	<++></head><body>	<++></body></html>:call BackwardMarker(2)
inoremap <buffer> ;tb <button <++> /><++>:call BackwardMarker(2)
inoremap <buffer> ;ti <img src="<++>" <++> /><++>:call BackwardMarker(3)
