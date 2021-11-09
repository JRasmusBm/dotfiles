vim.cmd [[
packadd! spelunker.vim
packadd! popup-menu.nvim

let g:spelunker_target_min_char_len = 4
let g:spelunker_max_suggest_words = 15
let g:spelunker_max_hi_words_each_buf = 100

let g:spelunker_check_type = 2 " Only visible text (not whole file)
let g:spelunker_highlight_type = 1 " All types
let g:spelunker_disable_uri_checking = 1
let g:spelunker_disable_email_checking = 1
let g:spelunker_disable_account_name_checking = 1
let g:spelunker_disable_acronym_checking = 1
let g:spelunker_disable_backquoted_checking = 1
let g:spelunker_disable_auto_group = 1

function! s:check_file() abort
  if &spell == 0
    call spelunker#check()
    silent! nmap ]s <Plug>(spelunker-jump-next)
    silent! nmap [s <Plug>(spelunker-jump-prev)
  else
    silent! nnoremap ]s ]s
    silent! nnoremap [s [s
  endif
endfunction

function! s:check_displayed_words() abort
  if &spell == 0
    call spelunker#check_displayed_words()
    silent! nmap ]s <Plug>(spelunker-jump-next)
    silent! nmap [s <Plug>(spelunker-jump-prev)
  else
    silent! nnoremap ]s ]s
    silent! nnoremap [s [s
  endif
endfunction

augroup spelunker
  autocmd!
  autocmd BufWinEnter,BufWritePost * call s:check_file()
  autocmd CursorHold * call s:check_displayed_words()
augroup END
]]
