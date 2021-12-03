" Loader {{{
inoremap <buffer> <leader>rl export const loader = musterLoader(async () => {
            \<++>
            \}):call bushels#backward_marker(1)
" }}}

" Action {{{
inoremap <buffer> <leader>ra export const action = musterAction(async () => {
            \<++>
            \}):call bushels#backward_marker(1)
" }}}

