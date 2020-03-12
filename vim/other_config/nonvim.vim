au BufRead *.pdf sil exe '!br ' . shellescape(expand('%:p')) | bd | let &ft=&ft | redraw!
au BufRead *.png,*.jpg sil exe '!xdg-open ' . shellescape(expand('%:p')) | bd | let &ft=&ft | redraw!
