" Tag
inoremap ;tg <++>O<<++> <++>/>:call BackwardMarker(2)
" Close Tag
inoremap ;ct T<ye/<++>n4s0:call BackwardMarker(1)
" Open Tag
inoremap ;ot <++>O</<++>>O<<++> <++>>	<++>:call BackwardMarker(3)
" Plain Tag Argument
inoremap ;ap <++>="<++>" <++>:call BackwardMarker(3)
" JSX Tag Argument
inoremap ;aj <++>={<++>} <++>:call BackwardMarker(3)
