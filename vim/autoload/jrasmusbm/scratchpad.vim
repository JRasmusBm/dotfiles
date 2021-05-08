function! jrasmusbm#scratchpad#exit() abort
  let @+ = join(getline(1, '$'), "\n")
  w! ~/.last-scratchpad
  %d   
  w! ~/.scratchpad
  qa!
endfunction
