autocmd BufRead *.test.* setlocal foldlevel=1
nnoremap <leader>zs :setlocal foldmethod=syntax
nnoremap <leader>zm :setlocal foldmethod=marker

set foldopen=block
set foldopen+=hor
set foldopen+=insert
set foldopen+=percent
set foldopen+=mark
set foldopen+=search
set foldopen+=tag
set foldopen+=undo
set foldopen+=quickfix

function! GetLines(...) abort
  return [line("'["), line("']")]
endfunction

function! FoldSelection(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif
  let [lnum1, lnum2] = GetLines(a:0, a:1)
  call append(lnum2, substitute(&cms, "%s", " {{{", ""))
  call append(lnum2+1, substitute(&cms, "%s", "}}}", ""))
  execute  lnum1 . "," . lnum2 . "m" . (lnum2+1)
  call cursor(lnum1, 3)
  norm zo
  startinsert 
endfunction
