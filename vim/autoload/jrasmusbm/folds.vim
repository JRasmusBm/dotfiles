function! jrasmusbm#folds#toggle_foldopen() abort
  if &foldopen == "all"
    set foldopen=block
    set foldopen+=hor
    set foldopen+=insert
    set foldopen+=percent
    set foldopen+=mark
    set foldopen+=search
    set foldopen+=tag
    set foldopen+=undo
    set foldopen+=quickfix
    set foldclose=""
    echo "manual"
  else
    set foldopen=all
    set foldclose=all
    echo "auto"
  endif
endfunction

function! jrasmusbm#folds#fold_selection(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif
  let [lnum1, lnum2] = jrasmusbm#utils#get_lines(a:0, a:1)
  call append(lnum2, substitute(&cms, "%s", " {{{", ""))
  call append(lnum2+1, substitute(&cms, "%s", "}}}", ""))
  execute  lnum1 . "," . lnum2 . "m" . (lnum2+1)
  call cursor(lnum1, 3)
  norm zo
  startinsert 
endfunction
