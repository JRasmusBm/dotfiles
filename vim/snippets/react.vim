" Import {{{
" React {{{
inoremap <buffer> <leader>ir import React from "react";
"}}}
"}}}

" React {{{
" Styled {{{
inoremap <buffer> <leader>rs const <++> = styled.<++>`
"}}}
" Component {{{
inoremap <buffer> <leader>rc const <++> = () => {
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
inoremap <buffer> <leader>hh const <++> = use<++>(<++>);
"}}}
" State {{{
inoremap <buffer> <leader>hs const [<++>, set<++>] = React.useState(<++>);
"}}}
" Reducer {{{
inoremap <buffer> <leader>hr const [{<++>}, dispatch] = React.useReducer(reducer, {<++>});
"}}}
" Effect {{{
inoremap <buffer> <leader>he React.useEffect(() => {<++>}, [<++>]);
"}}}
" Layout {{{
inoremap <buffer> <leader>hl React.useLayoutEffect(() => {<++>}, [<++>]);
"}}}
" Callback {{{
inoremap <buffer> <leader>hc const <++> = React.useCallback((<++>) => {
"}}}
" Memo {{{
inoremap <buffer> <leader>hm const <++> = React.useMemo((<++>) => {
"}}}
"}}}