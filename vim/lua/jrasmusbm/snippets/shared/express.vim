" Get {{{
inoremap <buffer> <leader>rg router.get("<++>", (req, res) => {
      \<++>
      \}):call bushels#backward_marker(2)
" }}}

" Post {{{
inoremap <buffer> <leader>rpo router.post("<++>", (req, res) => {
      \<++>
      \}):call bushels#backward_marker(2)
" }}}

" Put {{{
inoremap <buffer> <leader>rpu router.put("<++>", (req, res) => {
      \<++>
      \}):call bushels#backward_marker(2)
" }}}

" Delete {{{
inoremap <buffer> <leader>rd router.delete("<++>", (req, res) => {
      \<++>
      \}):call bushels#backward_marker(2)
" }}}

" Use {{{
inoremap <buffer> <leader>ru router.use("<++>");
      \:call bushels#backward_marker(1)
" }}}

" Middleware {{{
inoremap <buffer> <leader>rm (_req, _res, _next)  => {
      \<++>
      \}:call bushels#backward_marker(1)
" }}}

" Error Handler {{{
inoremap <buffer> <leader>re (_err, _req, _res, _next) => {
      \<++>
      \}:call bushels#backward_marker(1)
"}}}
