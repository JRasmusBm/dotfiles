inoremap <buffer> ;ft <++> :: <++> -> <++>:call BackwardMarker(3)
inoremap <buffer> ;vt <++> :: <++> :call BackwardMarker(2)
inoremap <buffer> ;tn :call ForwardMarker(1)<++> -> <++>:call BackwardMarker(2)
inoremap <buffer> ;tc (<++>) => <++>:call BackwardMarker(2)
inoremap <buffer> ;td data <++> = <++>:call BackwardMarker(2)
inoremap <buffer> ;ta type <++> = <++>:call BackwardMarker(2)
inoremap <buffer> ;ex module <++> where<++>:call BackwardMarker(2) 
inoremap <buffer> ;im import <++> :call BackwardMarker(1) 
inoremap <buffer> ;fm 0yEo" <++> = <++>:call BackwardMarker(2)
inoremap <buffer> ;fg 0yEo" <++> 	<Bar> <++> = <++>:call BackwardMarker(3)
inoremap <buffer> ;fi (\<++> -> <++>) <++> :call BackwardMarker(3)
inoremap <buffer> ;fc 0yEo" <++> = case(<++>) of o	<++> -> <++>:call BackwardMarker(4)
inoremap <buffer> ;cn o	<++> -> <++>:call BackwardMarker(2)
inoremap <buffer> ;gn o	<Bar> <++> = <++>:call BackwardMarker(2)
inoremap <buffer> ;lc [ <++> <Bar> <++> <- <++> ]:call BackwardMarker(3)
