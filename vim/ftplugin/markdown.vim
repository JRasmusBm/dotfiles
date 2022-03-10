setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal spell spelllang=en_us

setlocal wrap
setlocal textwidth=80

execute "source $DOTFILES/vim/snippets/markdown.vim"

command! PR norm gg/Ticketf[yi]/#f[v2f]p0WysaW]Wdw

let b:is_markdown_file = 1
