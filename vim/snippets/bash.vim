" Control Statement {{{
" For {{{
inoremap <buffer> <leader>cfo for i in {0..<++>}
    \do
    \<++>
    \done
    \<++>:call bushels#backward_marker(3)
" }}}
" For Each {{{
inoremap <buffer> <leader>cfe for <++> in <++>
    \do
    \<++>
    \done
    \<++>:call bushels#backward_marker(4)
" }}}
" If {{{
inoremap <buffer> <leader>ci if <++>; then
    \<++>
    \fi
    \<++>:call bushels#backward_marker(3)
" }}}
" Else {{{
inoremap <buffer> <leader>cie 
    \<++>
    \fi
    \<++>:call bushels#backward_marker(2)
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
  \<++>:call bushels#backward_marker(3)
" }}}
" }}}
" Tmux {{{ 
" File {{{
inoremap <buffer> <leader>tf #!/bin/bash
  \set -e
  \folder_path==expand("%:p:h")
  \folder_name=${folder_path##*/}
  \session_name=${folder_name//./_}
  \cd "$folder_name"
  \if ! tmux has-session -t="$session_name" 2> /dev/null; then
  \tmux new-session -d -s "$session_name" -n run -x "$(tput cols)" -y "$(tput lines)"
  \<++>
  \tmux new-window -n vim
  \tmux send-keys -t vim "vim -c GFiles" Enter
  \tmux new-window -n cli
  \tmux send-keys -t cli "g l" Enter
  \tmux send-keys -t cli "g" Enter
  \fi
  \if test ! "$INITIATED_EXTERNALLY" = 'true' ; then
  \ta ="$session_name":vim
  \fi
" }}}
" Session {{{
inoremap <buffer> <leader>ts tmux new-session -d -s <++> -n <++> -x $(tput cols) -y $(tput lines)
  \<++>:call bushels#backward_marker(3)
" }}}
" Window {{{
inoremap <buffer> <leader>tw tmux new-window -n <++>
  \<++>:call bushels#backward_marker(2)
" }}}
" Command {{{
inoremap <buffer> <leader>tc tmux send-keys -t <++> "<++>" Enter
  \<++>:call bushels#backward_marker(3)
" }}}
" Vertical {{{
inoremap <buffer> <leader>tv tmux split-window -t <++> -h
  \<++>:call bushels#backward_marker(2)
" }}}
" Horizontal {{{
inoremap <buffer> <leader>th tmux split-window -t <++>
  \<++>:call bushels#backward_marker(2)
" }}}
" Import {{{
inoremap <buffer> <leader>ti INITIATED_EXTERNALLY=true source_tmux_script<space>
" }}}
" Attach {{{
inoremap <buffer> <leader>ta tmux attach -t <++>
  \<++>:call bushels#backward_marker(2)
" }}}
" }}}
" Handle {{{
" C {{{
inoremap <buffer> <leader>hc trap_ctrlc() { <++>
  \exit 2
  \}
  \trap "trap_ctrlc" 2:call bushels#backward_marker(1)
" }}}
" }}}
" Alias {{{
inoremap <buffer> <leader>as alias "<++>"="<++>"
      \<++>:call bushels#backward_marker(3)
" }}}
