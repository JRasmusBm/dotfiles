command! -buffer -nargs=* G call jrasmusbm#git#run_and_refresh(match(<q-args>, "^\ *$") >= 0 ? "e .git/index" : ("Git " . <q-args>))

augroup GitCommitTreeRefresh
  autocmd! * <buffer>
  autocmd BufEnter <buffer> silent call jrasmusbm#git#list_tree()
augroup END
   
nmap <buffer> L :silent call jrasmusbm#git#list_tree()<CR>
nmap <buffer> H :silent e .git/index<CR>
