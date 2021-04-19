" Tag {{{
" Contained {{{
inoremap <buffer> <leader>tt <<++> />	<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Close {{{
function! CloseTag()
  let save_pos = getpos(".")
  execute "normal! T<yt>f>i <++>/<\/<++>>" .
        \":call jrasmusbm#snippets#forward_marker(1)0"
  call setpos('.', save_pos)
endfunction
inoremap <buffer> <leader>tc :call CloseTag():call jrasmusbm#snippets#forward_marker(1)
"}}}
" Open {{{
inoremap <buffer> <leader>to <<++>>	<++></<++>><<o<++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
"}}}

" Headers {{{
" H1 {{{
inoremap <buffer> <leader>h1 <h1 <++>><++></h1>o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" H2 {{{
inoremap <buffer> <leader>h2 <h2 <++>><++></h2>o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" H3 {{{
inoremap <buffer> <leader>h3 <h3 <++>><++></h3>o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" H4 {{{
inoremap <buffer> <leader>h4 <h4 <++>><++></h4>o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" H5 {{{
inoremap <buffer> <leader>h5 <h5 <++>><++></h5>o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" H6 {{{
inoremap <buffer> <leader>h6 <h6 <++>><++></h6>o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}

" Div {{{
inoremap <buffer> <leader>td <div <++>><++></div>o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}

" Argument {{{
" String {{{
inoremap <buffer> <leader>as <++>="<++>" <++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" JSX {{{
inoremap <buffer> <leader>aj <++>={<++>} <++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}

" File {{{
inoremap <buffer> <leader>tf <!DOCTYPE html><html>	<head>	<++></head><body>	<++></body></html>:call jrasmusbm#snippets#backward_marker(2)
"}}}

" Button {{{
inoremap <buffer> <leader>tb <button type="<++>" <++>><++></button><++>:call jrasmusbm#snippets#backward_marker(4)
"}}}

" Paragraph {{{
inoremap <buffer> <leader>tp <p><++></p><++>:call jrasmusbm#snippets#backward_marker(2)
"}}}

" Image {{{
inoremap <buffer> <leader>ti <img src="<++>" <++> /><++>:call jrasmusbm#snippets#backward_marker(3)
"}}}

" Form {{{
" Input {{{
inoremap <buffer> <leader>tfi <label>
      \<span><++></span>
      \<input <++>>
      \<++>
      \</input>
      \</label>o<++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Fieldset {{{
inoremap <buffer> <leader>tfs <fieldset><legend><++></legend><++></fieldset><++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}

" Bullet {{{
" List {{{
inoremap <buffer> <leader>tbl <ul>
  \<li><++></li>
  \</ul><++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>tbn <li><++></li>
  \<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" Numbered {{{
" List {{{
inoremap <buffer> <leader>tnl <ol>
  \<li><++></li>
  \</ol><++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>tnn <li><++></li>
  \<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" Import {{{
" StyleSheet {{{
inoremap <buffer> <leader>tis <link rel="stylesheet" href="<++>.css" />
      \<++>:call jrasmusbm#snippets#backward_marker(2)

" }}}
" JavaScript {{{
inoremap <buffer> <leader>tij <script src="<++>.js"></script>
      \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}

" Viewport {{{
inoremap <buffer> <leader>tvp <meta name="viewport" content="width=device-width, initial-scale=1" />
" }}}
