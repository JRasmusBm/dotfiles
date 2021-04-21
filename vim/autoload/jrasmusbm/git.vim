function! jrasmusbm#git#start_review(revision) abort
  let g:current_diff_reference=a:revision
  call vcsjump#jump(0, "diff " . a:revision)
endfunction

function! jrasmusbm#git#close_diff() abort
  diffoff
  q
endfunction

function! jrasmusbm#git#end_review(revision) abort
  call jrasmusbm#git#close_diff()
  cclose
endfunction

function! jrasmusbm#git#open_diff() abort
  if g:current_diff_reference == ""
    echom "Empty revision"
    return 
  endif
  execute("Gvdiffsplit!" . g:current_diff_reference)
endfunction

function! jrasmusbm#git#next_changes() abort
  call jrasmusbm#git#close_diff()
  cnf
  call jrasmusbm#git#open_diff()
endfunction

function! jrasmusbm#git#previous_changes() abort
  call jrasmusbm#git#close_diff()
  cpf
  call jrasmusbm#git#open_diff()
endfunction
