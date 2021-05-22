" Test {{{
" Case {{{
inoremap <buffer> <leader>dc it("<++>", async (): Promise<void> => {
      \Sthrow "Not implemented!";
      \})
      \<++><<$:call bushels#backward_marker(2)
" }}}
" Expect {{{
" Called {{{
inoremap <buffer> <leader>dec const calls = <++>.getCalls()
      \expect(calls).to.have.length(1)
      \expect(calls[0].args).to.deep.equal([{<++>}])
      \:call bushels#backward_marker(2)
      
" }}}
" Deep {{{
inoremap <buffer> <leader>ded expect(<++>).to.deep.equal(<++>)
      \:call bushels#backward_marker(2)
" }}}
"}}}
"}}}
