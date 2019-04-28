au BufRead *.pdf sil exe '!chr ' . shellescape(expand('%:p')) | bd | let &ft=&ft | redraw!
