inoremap <buffer> <leader>ft <++> :: <++> -> <++>:call BackwardMarker(3)
inoremap <buffer> <leader>vt <++> :: <++> :call BackwardMarker(2)
inoremap <buffer> <leader>tn :call ForwardMarker(1)<++> -> <++>:call BackwardMarker(2)
inoremap <buffer> <leader>tc (<++>) => <++>:call BackwardMarker(2)
inoremap <buffer> <leader>td data <++> = <++> deriving (<++>)<++>:call BackwardMarker(4)
inoremap <buffer> <leader>cd class <++> where<++><++>:call BackwardMarker(3) 
inoremap <buffer> <leader>is instance <++> where<++><++>:call BackwardMarker(3) 
inoremap <buffer> <leader>ta type <++> = <++>:call BackwardMarker(2)
inoremap <buffer> <leader>ex module <++> where<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>im import <++> :call BackwardMarker(1) 
inoremap <buffer> <leader>fm 0yEo" <++> = <++>:call BackwardMarker(2)
inoremap <buffer> <leader>fg 0yEo" <++> 	<Bar> <++> = <++>:call BackwardMarker(3)
inoremap <buffer> <leader>fi (\<++> -> <++>) <++> :call BackwardMarker(3)
inoremap <buffer> <leader>fc 0yEo" <++> = case(<++>) of o	<++> -> <++>:call BackwardMarker(4)
inoremap <buffer> <leader>cn o	<++> -> <++>:call BackwardMarker(2)
inoremap <buffer> <leader>gn o	<Bar> <++> = <++>:call BackwardMarker(2)
inoremap <buffer> <leader>lc [ <++> <Bar> <++> <- <++> ]:call BackwardMarker(3)
