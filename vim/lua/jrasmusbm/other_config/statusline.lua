function! InactiveStatusLine() abort
  return luaeval("require('jrasmusbm.statusline').inactiveStatusLine()")
endfunction

function! ActiveStatusLine() abort
  return luaeval("require('jrasmusbm.statusline').activeStatusLine()")
endfunction

augroup JRasmusBm_Statusline
  autocmd!
  autocmd FocusGained,BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * setlocal statusline=%!ActiveStatusLine()
  autocmd FocusLost,WinLeave * setlocal statusline=%!InactiveStatusLine()
augroup END
