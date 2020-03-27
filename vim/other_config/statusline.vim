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

function! PinnacleActive()
  try
    call pinnacle#highlight({})
    return 1
  catch /E117/
    " Pinnacle probably isn't loaded
    return 0
  endtry
endfunction

function! SetModeColors(mode) abort
  if !PinnacleActive()
    return ""
  endif

  let l:mode_text=get(g:mode_map, a:mode)
  let l:bg = pinnacle#extract_fg('Cursor')
  let l:fg = pinnacle#extract_fg("Keyword")
  " echom l:mode_text
  " if l:mode_text == "VISUAL"
  "   let l:fg=pinnacle#extract_fg("Constant")
  " elseif l:mode_text == "INSERT"
  "   let l:fg=pinnacle#extract_fg("Identifier")
  " endif
  execute 'highlight User2 ' . pinnacle#highlight({'fg': l:fg, 'bg': l:bg})
  execute 'highlight User3 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': l:bg,
        \   'term': 'bold'
        \ })
  return ""
endfunction


function! FocusStatusline() abort
  if has("statusline")
    setlocal statusline=%3*
    setlocal statusline+=%{SetModeColors(mode(1))}
    setlocal statusline+=\ %{get(mode_map,mode(1))}
    setlocal statusline+=\ 
    setlocal statusline+=%2*
    setlocal statusline+=
    setlocal statusline+=%1*
    setlocal statusline+=\ %f
    setlocal statusline+=%=
    setlocal statusline+=%#CocWarningSign#
    setlocal statusline+=%{CoCWarnings()}
    setlocal statusline+=%1*
    setlocal statusline+=\ 
    setlocal statusline+=%#CocErrorSign#
    setlocal statusline+=%{CoCErrors()}
    setlocal statusline+=%1*
    setlocal statusline+=\ %y\ 
    setlocal statusline+=%2*
    setlocal statusline+=
    setlocal statusline+=%3*
    setlocal statusline+=\ %l,
    setlocal statusline+=\ %c
    setlocal statusline+=\ 
  endif
endfunction

function! BlurStatusLine() abort
  if has("statusline")
    setlocal statusline=%1*
    setlocal statusline+=%{SetModeColors(mode(1))}
    setlocal statusline+=\ %{get(mode_map,mode(1))}
    setlocal statusline+=\ 
    setlocal statusline+=\ 
    setlocal statusline+=\ %f
    setlocal statusline+=%=
    setlocal statusline+=%{CoCWarnings()}
    setlocal statusline+=\ 
    setlocal statusline+=%{CoCErrors()}
    setlocal statusline+=\ %y\ 
    setlocal statusline+=\ 
    setlocal statusline+=\ %l,
    setlocal statusline+=\ %c
    setlocal statusline+=\ 
  endif
endfunction

function! CoCWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'warning', 0)
    return '⚠ ' . info['warning']
  endif
  return ""
endfunction

function! CoCErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'error', 0)
    return '✗ ' . info['error']
  endif
  return ""
endfunction

augroup StatusLine
  autocmd!
  if exists('##TextChangedI')
    autocmd FocusGained,BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call FocusStatusline()
  else
    autocmd FocusGained,BufWinEnter,BufWritePost,FileWritePost,WinEnter * call FocusStatusline()
  endif
  autocmd FocusLost,WinLeave * call BlurStatusLine()
augroup END
