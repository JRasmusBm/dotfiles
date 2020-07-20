autocmd BufRead *.test.* setlocal foldlevel=1

function! GetLines(...) abort
  return [line("'["), line("']")]
endfunction

function! FoldSelection(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif
  let [lnum1, lnum2] = GetLines(a:0, a:1)
  call append(lnum2, "\"  {{{")
  call append(lnum2+1, "\"}}}")
  execute  lnum1 . "," . lnum2 . "m" . (lnum2+1)
  call cursor(lnum1, 3)
  norm zo
  startinsert
endfunction
