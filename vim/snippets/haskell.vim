" Type {{{
" Function {{{
inoremap <buffer> <leader>tf <++> :: <++> -> <++>:call BackwardMarker(3)
"}}}
" Variable {{{
inoremap <buffer> <leader>tv <++> :: <++> :call BackwardMarker(2)
"}}}
" Alias {{{
inoremap <buffer> <leader>ta type <++> = <++>:call BackwardMarker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>tn :call ForwardMarker(1)<++> -> <++>:call BackwardMarker(2)
"}}}
" Constraint {{{
inoremap <buffer> <leader>tc (<++>) => <++>:call BackwardMarker(2)
"}}}
" Data {{{
inoremap <buffer> <leader>td data <++> = <++> deriving (<++>)<++>:call BackwardMarker(4)
"}}}
"}}}

" Class {{{
" Definition {{{
inoremap <buffer> <leader>cd class <++> where<++><++>:call BackwardMarker(3)
"}}}
"}}}

" Instance {{{
inoremap <buffer> <leader>is instance <++> where<++><++>:call BackwardMarker(3)
"}}}

" Export {{{
inoremap <buffer> <leader>ex module <++> where<++>:call BackwardMarker(2)
"}}}

" Import {{{
inoremap <buffer> <leader>im import <++> :call BackwardMarker(1) 
"}}}

" Function {{{
" Match {{{
inoremap <buffer> <leader>fm 0yEo" <++> = <++>:call BackwardMarker(2)
"}}}
" Guard {{{
inoremap <buffer> <leader>fg 0yEo" <++> 	<Bar> <++> = <++>:call BackwardMarker(3)
"}}}
" Guard Node {{{
inoremap <buffer> <leader>gn o	<Bar> <++> = <++>:call BackwardMarker(2)
"}}}
" Inline {{{
inoremap <buffer> <leader>fi (\<++> -> <++>) <++> :call BackwardMarker(3)
"}}}
" Case {{{
inoremap <buffer> <leader>fc 0yEo" <++> = case(<++>) of o	<++> -> <++>:call BackwardMarker(4)
"}}}
" Case Node {{{
inoremap <buffer> <leader>cn o	<++> -> <++>:call BackwardMarker(2)
"}}}
"}}}

" List Comprehension {{{
inoremap <buffer> <leader>lc [ <++> <Bar> <++> <- <++> ]:call BackwardMarker(3)
"}}}
