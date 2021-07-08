command! Emojify keeppatterns %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

augroup Emoji
  autocmd!
  autocmd InsertLeave Emojify
augroup END
