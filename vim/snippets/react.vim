" Import {{{
" React {{{
inoremap <buffer> <leader>ir import React from "react";
"}}}
"}}}

" React {{{
" Styled {{{
inoremap <buffer> <leader>rs const <++> = styled.<++>`<++>`<++>:call bushels#backward_marker(4)
"}}}
" Component {{{
inoremap <buffer> <leader>rc const <++> = () => {<++>}<++>:call bushels#backward_marker(3)
"}}}
" File {{{
inoremap <buffer> <leader>rf import React from "react";
      \const <++> = () => {
      \return <++>;
      \}
      \export default <++>;:call bushels#backward_marker(3)
"}}}
" Reducer {{{
inoremap <buffer> <leader>rr const reducer = (state, action) => {
      \switch (action.type) {
      \case <++>:
      \return produce(state, draftState => {
      \<++>
      \})
      \<++>
      \default:
      \return state
      \}
      \}:call bushels#backward_marker(3)
" }}}
" Action {{{
inoremap <buffer> <leader>ra case <++>:
      \return produce(state, draftState => {
      \<++>
      \})
      \<++>:call bushels#backward_marker(3)
" }}}
"}}}


" Hooks {{{
" Specify {{{
inoremap <buffer> <leader>hh const <++> = use<++>(<++>);<++>:call bushels#backward_marker(4)
"}}}
" State {{{
inoremap <buffer> <leader>hs const [<++>, set<++>] = React.useState(<++>);<++>:call bushels#backward_marker(4)
"}}}
" Reducer {{{
inoremap <buffer> <leader>hr const [{<++>}, dispatch] = React.useReducer(reducer, {<++>});<++>:call bushels#backward_marker(3)
"}}}
" Effect {{{
inoremap <buffer> <leader>he React.useEffect(() => {<++>}, [<++>]);<++>:call bushels#backward_marker(3)
"}}}
" Layout {{{
inoremap <buffer> <leader>hl React.useLayoutEffect(() => {<++>}, [<++>]);<++>:call bushels#backward_marker(3)
"}}}
" Callback {{{
inoremap <buffer> <leader>hc const <++> = React.useCallback((<++>) => {<++>}, [<++>]);<++>:call bushels#backward_marker(5)
"}}}
" Memo {{{
inoremap <buffer> <leader>hm const <++> = React.useMemo((<++>) => {<++>}, [<++>]);<++>:call bushels#backward_marker(5)
"}}}
"}}}
