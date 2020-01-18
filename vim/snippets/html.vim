" Tag
inoremap <buffer> <leader>tt <<++> />	<++>:call BackwardMarker(2)
" Close Tag
function! CloseTag()
  let save_pos = getpos(".")
  execute "normal! T<yt>f>i <++>/<\/<++>>" .
        \":call ForwardMarker(1)0"
  call setpos('.', save_pos)
endfunction
inoremap <buffer> <leader>tc :call CloseTag():call ForwardMarker(1)
inoremap <buffer> <leader>td <div <++>><++></div>o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>h1 <h1 <++>><++></h1>o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>h2 <h2 <++>><++></h2>o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>h3 <h3 <++>><++></h3>o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>h4 <h4 <++>><++></h4>o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>h5 <h5 <++>><++></h5>o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>h6 <h6 <++>><++></h6>o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>to <<++>>	<++></<++>><<o<++>:call BackwardMarker(4)
" String Tag Argument
inoremap <buffer> <leader>as <++>="<++>" <++>:call BackwardMarker(3)
" JSX Tag Argument
"Arguments
inoremap <buffer> <leader>aj <++>={<++>} <++>:call BackwardMarker(3)
" File Generation
inoremap <buffer> <leader>tf <!DOCTYPE html><html>	<head>	<++></head><body>	<++></body></html>:call BackwardMarker(2)
" Semantic Elements
inoremap <buffer> <leader>tb <button type="<++>" <++>><++></button><++>:call BackwardMarker(4)
inoremap <buffer> <leader>tp <p><++></p><++>:call BackwardMarker(2)
inoremap <buffer> <leader>ti <img src="<++>" <++> /><++>:call BackwardMarker(3)
inoremap <buffer> <leader>tfi <label>
      \<span><++></span>
      \<input <++>>
      \<++>
      \</input>
      \</label>o<++>:call BackwardMarker(4)
inoremap <buffer> <leader>tfs <fieldset><legend><++></legend><++></fieldset><++>:call BackwardMarker(3)
inoremap <buffer> <leader>tbl <ul>
  \<li><++></li>
  \</ul><++>:call BackwardMarker(2)
inoremap <buffer> <leader>tbn <li><++></li>
  \<++>:call BackwardMarker(2)
inoremap <buffer> <leader>tnl <ol>
  \<li><++></li>
  \</ol><++>:call BackwardMarker(2)
inoremap <buffer> <leader>tnn <li><++></li>
  \<++>:call BackwardMarker(2)
