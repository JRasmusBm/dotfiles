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
  \if tmux has-session -t=<++> 2> /dev/null; then
  \tmux attach -t <++>
  \exit
  \fi
  \tmux new-session -d -s <++> -n <++> -x $(tput cols) -y $(tput lines)
  \<++>:call BackwardMarker(5)
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
" Attach {{{
inoremap <buffer> <leader>ta tmux attach -t <++>
  \<++>:call BackwardMarker(2)
" }}}
" }}}
