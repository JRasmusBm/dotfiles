vim.cmd [[
augroup Ruler
  autocmd WinEnter * :silent call jrasmusbm#ruler#source()
  autocmd WinLeave * :silent call jrasmusbm#ruler#off()
augroup END

silent call jrasmusbm#ruler#source()

nnoremap <Leader>sr :call jrasmusbm#ruler#toggle()
]]
