" Tag
inoremap <buffer> ;tg <++>O<<++> <++>/>:call BackwardMarker(2)
" Close Tag
inoremap <buffer> ;ct T<ye/<++>n4s0:call BackwardMarker(1)
" Open Tag
inoremap <buffer> ;ot <++>O</<++>>O<<++> <++>>	<++>:call BackwardMarker(3)
" Plain Tag Argument
inoremap <buffer> ;ap <++>="<++>" <++>:call BackwardMarker(3)
" JSX Tag Argument
inoremap <buffer> ;aj <++>={<++>} <++>:call BackwardMarker(3)
