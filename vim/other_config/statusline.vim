let mode_map = {
      \ '__' : '------',
      \ 'c'  : 'COMMAND',
      \ 'i'  : 'INSERT',
      \ 'ic' : 'INSERT',
      \ 'ix' : 'INSERT',
      \ 'multi' : 'MULTI',
      \ 'n'  : 'NORMAL',
      \ 'ni' : '(INSERT)',
      \ 'no' : 'OP PENDING',
      \ 'R'  : 'REPLACE',
      \ 'Rv' : 'V REPLACE',
      \ 's'  : 'SELECT',
      \ 'S'  : 'S-LINE',
      \ '' : 'S-BLOCK',
      \ 't'  : 'TERMINAL',
      \ 'v'  : 'VISUAL',
      \ 'V'  : 'V-LINE',
      \ '' : 'V-BLOCK',
      \ }

if has("statusline")
  set statusline+=%*
  set statusline=%1*
  set statusline+=\ %{get(mode_map,mode())}
  set statusline+=\ 
  set statusline+=%7*
  set statusline+=\ %f
  set statusline+=%=
  set statusline+=\ %y
  set statusline+=\ 
  set statusline+=\ %l,
  set statusline+=\ %c
  set statusline+=\ 
endif
