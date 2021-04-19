function! jrasmusbm#git#changes(revision) abort
  let g:current_diff_reference=a:revision
  call vcsjump#jump(0, "diff " . a:revision)
endfunction

function! jrasmusbm#git#open_diff() abort
  if g:current_diff_reference == ""
    echom "Empty revision"
    return 
  endif
  execute("Gvdiffsplit!" . g:current_diff_reference)
endfunction

function! jrasmusbm#git#next_changes() abort
  diffoff
  q
  cnf
  call jrasmusbm#git#open_diff()
endfunction

function! jrasmusbm#git#previous_changes() abort
  diffoff
  q
  cpf
  call jrasmusbm#git#open_diff()
endfunction
