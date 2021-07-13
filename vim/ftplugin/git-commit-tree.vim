command! -buffer -nargs=* G call jrasmusbm#git#run_and_refresh(<q-args>)

augroup GitCommitTreeRefresh
  autocmd! * <buffer>
  autocmd BufEnter <buffer> silent call jrasmusbm#git#list_tree()
augroup END

nmap gq :e .git/index<CR>
nmap <buffer> L :silent call jrasmusbm#git#list_tree()<CR>
