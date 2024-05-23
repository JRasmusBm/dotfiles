function! s:ankify() abort
  %s/\v^- (.*)/\1/
  1d
  %s/\v^ +//
endfunction

command! Ankify call s:ankify()
