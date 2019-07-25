au BufRead *.pdf sil exe '!br ' . shellescape(expand('%:p')) | bd | let &ft=&ft | redraw!
