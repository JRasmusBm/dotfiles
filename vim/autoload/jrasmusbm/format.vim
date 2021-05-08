function! jrasmusbm#format#default() abort
  let current_position = getpos(".")
  g/^$/,/./-j
  norm gg=G
  call setpos(".", current_position)
endfunction
