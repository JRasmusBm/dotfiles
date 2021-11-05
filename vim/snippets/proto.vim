" Message {{{
inoremap <buffer> <leader>m message <++> {
      \<++>
      \}:call bushels#backward_marker(2)
" }}}

" Service {{{
inoremap <buffer> <leader>s service <++> {
      \<++>
      \}:call bushels#backward_marker(2)
" }}}

" Endpoint {{{
inoremap <buffer> <leader>e rpc <++>(<++>Req) returns (<++>Resp) {}:call bushels#backward_marker(3)
" }}}

" Complete Endpoint {{{
inoremap <buffer> <leader>c <cmd>call bushels#forward_marker(1)<CR>.
      \<cmd>call bushels#forward_marker(1)<CR>.^
" }}}

" Fields {{{
" List {{{
inoremap <buffer> <leader>fl repeated<Space>
" }}}
" Custom Type {{{
inoremap <buffer> <leader>ft <++> = 0;
      \:call bushels#backward_marker(2)
" }}}
" String {{{
inoremap <buffer> <leader>fs string <++> = 0;
      \<++>:call bushels#backward_marker(2)
" }}}
" Int {{{
inoremap <buffer> <leader>fi int32 <++> = 0;
      \<++>:call bushels#backward_marker(2)
" }}}
" Bool {{{
inoremap <buffer> <leader>fb bool <++> = 0;
      \<++>:call bushels#backward_marker(2)
" }}}
" }}}
