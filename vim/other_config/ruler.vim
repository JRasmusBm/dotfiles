augroup Ruler
  autocmd WinEnter * :silent call jrasmusbm#ruler#source()
  autocmd WinLeave * :silent call jrasmusbm#ruler#off()
augroup END

nnoremap <Leader>sr :call jrasmusbm#ruler#toggle()
