packadd! vim-hardtime

let g:hardtime_default_on = 0
let g:hardtime_maxcount = 1
let g:hardtime_timeout = 500
let g:hardtime_allow_different_key = 1

nnoremap <leader>ht :HardTimeToggle

command! VBG packadd vim-be-good | VimBeGood
