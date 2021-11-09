vim.cmd [[
function! Emojify() abort
  let pos = getpos(".")
  keeppatterns %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
  call setpos(".", pos)
endfunction

command! Emojify call Emojify()
]]
