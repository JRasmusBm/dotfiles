augroup Ruler
  autocmd WinEnter * :silent call jrasmusbm#ruler#source()
  autocmd WinLeave * :silent call jrasmusbm#ruler#off()
augroup END

call jrasmusbm#ruler#source()

nnoremap <Leader>sr :call jrasmusbm#ruler#toggle()
