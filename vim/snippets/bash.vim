" Control Statement {{{
" For {{{
inoremap <buffer> <leader>cfo for i in {0..<++>}
    \do
    \<++>
    \done
    \<++>:call BackwardMarker(3)
" }}}
" For Each {{{
inoremap <buffer> <leader>cfe for <++> in <++>
    \do
    \<++>
    \done
    \<++>:call BackwardMarker(4)
" }}}
" If {{{
inoremap <buffer> <leader>ci if <++>; then
    \<++>
    \fi
    \<++>:call BackwardMarker(3)
" }}}
" Else {{{
inoremap <buffer> <leader>cie 
    \<++>
    \fi
    \<++>:call BackwardMarker(2)
" }}}
" }}}
" Script {{{
" File {{{
inoremap <buffer> <leader>sf #!/bin/sh
  \set -e
" }}}
" }}}
" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd <++>() {<++>}
  \<++>:call BackwardMarker(3)
" }}}
" }}}
" Tmux {{{ 
" File {{{
inoremap <buffer> <leader>tf #!/bin/bash
  \set -e
  \previous_dir=$(pwd)
  \cd =expand("%:p:h")
  \if ! tmux has-session -t=<++> 2> /dev/null; then
  \tmux new-session -d -s <++> -n <++> -x $(tput cols) -y $(tput lines)
  \<++>
  \fi
  \if [ "$INITIATED_EXTERNALLY" = 'true' ]; then
  \:
  \else
  \tmux attach -t <++>
  \fi
  \cd "$previous_dir":call BackwardMarker(5)
" }}}
" Session {{{
inoremap <buffer> <leader>ts tmux new-session -d -s <++> -n <++> -x $(tput cols) -y $(tput lines)
  \<++>:call BackwardMarker(3)
" }}}
" Window {{{
inoremap <buffer> <leader>tw tmux new-window -n <++>
  \<++>:call BackwardMarker(2)
" }}}
" Command {{{
inoremap <buffer> <leader>tc tmux send-keys -t <++> "<++>" Enter
  \<++>:call BackwardMarker(3)
" }}}
" Vertical {{{
inoremap <buffer> <leader>tv tmux split-window -t <++> -h
  \<++>:call BackwardMarker(2)
" }}}
" Horizontal {{{
inoremap <buffer> <leader>th tmux split-window -t <++>
  \<++>:call BackwardMarker(2)
" }}}
" Import {{{
inoremap <buffer> <leader>ti INITIATED_EXTERNALLY=true source<space>
" }}}
" Attach {{{
inoremap <buffer> <leader>ta tmux attach -t <++>
  \<++>:call BackwardMarker(2)
" }}}
" }}}
" Handle {{{
" C {{{
inoremap <buffer> <leader>hc trap_ctrlc() { <++>
  \exit 2
  \}
  \trap "trap_ctrlc" 2:call BackwardMarker(1)
" }}}
" }}}
" Alias {{{
inoremap <buffer> <leader>as alias "<++>"="<++>"
      \<++>:call BackwardMarker(3)
" }}}
