function! jrasmusbm#utils#get_lines(...) abort
  return [line("'["), line("']")]
endfunction

function! jrasmusbm#utils#close_file() abort
    bd 
    let &ft=&ft 
    redraw! 
endfunction

