function! CloseNonvim() abort
    bd 
    let &ft=&ft 
    redraw! 
endfunction


au BufRead *.pdf sil exe '!br ' . shellescape(expand('%:p')) | call CloseNonvim()
au BufRead *.png,*.jpg sil exe '!xdg-open ' . shellescape(expand('%:p')) | call CloseNonvim()
