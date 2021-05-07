let s:isVisible = 0

function! jrasmusbm#ruler#toggle() abort
  if s:isVisible == 1
    let s:isVisible = 0
  else
    let s:isVisible = 1
  endif
  call jrasmusbm#ruler#source()
endfunction

function! jrasmusbm#ruler#source() abort
  if s:isVisible == 1
    call jrasmusbm#ruler#off()
  else
    call jrasmusbm#ruler#on()
  endif
endfunction

function! jrasmusbm#ruler#on() abort
  set cursorline
  set cursorcolumn
  echo "Ruler: On"
endfunction

function! jrasmusbm#ruler#off() abort
  set nocursorline
  set nocursorcolumn
  echo "Ruler: Off"
endfunction

