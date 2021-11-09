vim.cmd [[
augroup Nonvim
  au BufRead *.pdf sil exe '!br ' . shellescape(expand('%:p')) | call jrasmusbm#utils#close_file()
  au BufRead *.png,*.jpg sil exe '!xdg-open ' . shellescape(expand('%:p')) | call jrasmusbm#utils#close_file()
augroup END
]]
