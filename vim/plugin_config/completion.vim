packadd! vim-emoji

set completefunc=emoji#complete

command! Emojify keeppatterns %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
