setlocal norelativenumber
setlocal number

augroup Speeddial
  autocmd!
  autocmd BufEnter <buffer> norm gg0
augroup END
