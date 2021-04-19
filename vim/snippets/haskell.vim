" Type {{{
" Function {{{
inoremap <buffer> <leader>tf <++> :: <++> -> <++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Variable {{{
inoremap <buffer> <leader>tv <++> :: <++> :call jrasmusbm#snippets#backward_marker(2)
"}}}
" Alias {{{
inoremap <buffer> <leader>ta type <++> = <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>tn :call jrasmusbm#snippets#forward_marker(1)<++> -> <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Constraint {{{
inoremap <buffer> <leader>tc (<++>) => <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Data {{{
inoremap <buffer> <leader>td data <++> = <++> deriving (<++>)<++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
"}}}

" Class {{{
" Definition {{{
inoremap <buffer> <leader>cd class <++> where<++><++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}

" Instance {{{
inoremap <buffer> <leader>is instance <++> where<++><++>:call jrasmusbm#snippets#backward_marker(3)
"}}}

" Export {{{
inoremap <buffer> <leader>ex module <++> where<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}

" Import {{{
inoremap <buffer> <leader>im import <++> :call jrasmusbm#snippets#backward_marker(1) 
"}}}

" Function {{{
" Match {{{
inoremap <buffer> <leader>fm 0yEo" <++> = <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Guard {{{
inoremap <buffer> <leader>fg 0yEo" <++> 	<Bar> <++> = <++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Guard Node {{{
inoremap <buffer> <leader>gn o	<Bar> <++> = <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Inline {{{
inoremap <buffer> <leader>fi (\<++> -> <++>) <++> :call jrasmusbm#snippets#backward_marker(3)
"}}}
" Case {{{
inoremap <buffer> <leader>fc 0yEo" <++> = case(<++>) of o	<++> -> <++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Case Node {{{
inoremap <buffer> <leader>cn o	<++> -> <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" List Comprehension {{{
inoremap <buffer> <leader>lc [ <++> <Bar> <++> <- <++> ]:call jrasmusbm#snippets#backward_marker(3)
"}}}
