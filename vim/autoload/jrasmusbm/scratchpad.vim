function! jrasmusbm#scratchpad#exit() abort
  silent w!
  silent !~/projects/pyautogui/.venv/bin/python ~/projects/pyautogui/paste-scratchpad.py
  %d
  silent w!
  qa!
endfunction

function! jrasmusbm#scratchpad#start() abort
  set filetype=markdown.scratchpad
  call feedkeys("GA")
endfunction
