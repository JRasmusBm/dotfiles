" Tag {{{
" Contained {{{
inoremap <buffer> <leader>tt <<++> />	<++>:call bushels#backward_marker(2)
"}}}
" Close {{{
function! CloseTag()
  let save_pos = getpos(".")
  execute "normal! T<yt>f>i <++>/<\/<++>>" .
        \":call bushels#forward_marker(1)0"
  call setpos('.', save_pos)
endfunction
inoremap <buffer> <leader>tc :call CloseTag():call bushels#forward_marker(1)
"}}}
" Open {{{
inoremap <buffer> <leader>to <<++>>	<++></<++>><<o<++>:call bushels#backward_marker(4)
"}}}
"}}}

" Headers {{{
" H1 {{{
inoremap <buffer> <leader>h1 <h1 <++>><++></h1>o<++>:call bushels#backward_marker(3)
"}}}
" H2 {{{
inoremap <buffer> <leader>h2 <h2 <++>><++></h2>o<++>:call bushels#backward_marker(3)
"}}}
" H3 {{{
inoremap <buffer> <leader>h3 <h3 <++>><++></h3>o<++>:call bushels#backward_marker(3)
"}}}
" H4 {{{
inoremap <buffer> <leader>h4 <h4 <++>><++></h4>o<++>:call bushels#backward_marker(3)
"}}}
" H5 {{{
inoremap <buffer> <leader>h5 <h5 <++>><++></h5>o<++>:call bushels#backward_marker(3)
"}}}
" H6 {{{
inoremap <buffer> <leader>h6 <h6 <++>><++></h6>o<++>:call bushels#backward_marker(3)
"}}}
"}}}

" Div {{{
inoremap <buffer> <leader>td <div <++>><++></div>o<++>:call bushels#backward_marker(3)
"}}}

" Argument {{{
" String {{{
inoremap <buffer> <leader>as <++>="<++>" <++>:call bushels#backward_marker(3)
"}}}
" JSX {{{
inoremap <buffer> <leader>aj <++>={<++>} <++>:call bushels#backward_marker(3)
"}}}
"}}}

" File {{{
inoremap <buffer> <leader>tf <!DOCTYPE html><html>	<head>	<++></head><body>	<++></body></html>:call bushels#backward_marker(2)
"}}}

" Form {{{
inoremap <buffer> <leader>tfo <form method="post">
      \<++>
      \</form>:call bushels#backward_marker(1)
" Submit {{{
inoremap <buffer> <leader>tfs <button type="submit" <++>><++></button><++>:call bushels#backward_marker(3)
"}}}
" Input {{{
inoremap <buffer> <leader>tfi <input type="<++>" />
      \:call bushels#backward_marker(1)
"}}}
" Label {{{
inoremap <buffer> <leader>tfl <label>
      \<span><++></span>
      \<++>
      \</label>o<++>:call bushels#backward_marker(3)
"}}}
" Fieldset {{{
inoremap <buffer> <leader>tff <fieldset><legend><++></legend><++></fieldset><++>:call bushels#backward_marker(3)
"}}}
" }}}

" Button {{{
inoremap <buffer> <leader>tb <button type="<++>" <++>><++></button><++>:call bushels#backward_marker(4)
"}}}

" Paragraph {{{
inoremap <buffer> <leader>tp <p><++></p><++>:call bushels#backward_marker(2)
"}}}

" Image {{{
inoremap <buffer> <leader>ti <img src="<++>" <++> /><++>:call bushels#backward_marker(3)
"}}}

" Bullet {{{
" List {{{
inoremap <buffer> <leader>tbl <ul>
  \<li><++></li>
  \</ul><++>:call bushels#backward_marker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>tbn <li><++></li>
  \<++>:call bushels#backward_marker(2)
"}}}
"}}}

" Numbered {{{
" List {{{
inoremap <buffer> <leader>tnl <ol>
  \<li><++></li>
  \</ol><++>:call bushels#backward_marker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>tnn <li><++></li>
  \<++>:call bushels#backward_marker(2)
"}}}
"}}}

" Import {{{
" StyleSheet {{{
inoremap <buffer> <leader>tis <link rel="stylesheet" href="<++>.css" />
      \<++>:call bushels#backward_marker(2)

" }}}
" JavaScript {{{
inoremap <buffer> <leader>tij <script src="<++>.js"></script>
      \<++>:call bushels#backward_marker(2)
" }}}
" }}}

" Viewport {{{
inoremap <buffer> <leader>tvp <meta name="viewport" content="width=device-width, initial-scale=1" />
" }}}
