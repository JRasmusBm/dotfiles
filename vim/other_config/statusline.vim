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

let s:status_highlight='ModeMsg'
function! UpdateHighlight() abort
  if !PinnacleActive()
    return
  endif

  " Update StatusLine to use italics (used for filetype).
  let l:highlight=pinnacle#italicize('StatusLine')
  execute 'highlight User1 ' . l:highlight

  " Update MatchParen to use italics (used for blurred statuslines).
  let l:highlight=pinnacle#italicize('MatchParen')
  execute 'highlight User2 ' . l:highlight

  " StatusLine + bold (used for file names).
  let l:fg=pinnacle#extract_fg("Keyword")
  " let l:highlight=pinnacle#embolden('StatusLine')
  execute 'highlight User3 ' . pinnacle#highlight({'fg': l:fg})

  " Inverted Error styling, for left-hand side "Powerline" triangle.
  let l:fg=pinnacle#extract_fg("Constant")
  let l:bg=pinnacle#extract_bg('StatusLine')
  execute 'highlight User4 ' . pinnacle#highlight({'bg': l:bg, 'fg': l:fg})

  " And opposite for the buffer number area.
  execute 'highlight User7 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': pinnacle#extract_fg('Normal'),
        \   'term': 'bold'
        \ })

  " Right-hand side section.
  let l:bg=pinnacle#extract_fg('Cursor')
  let l:fg=pinnacle#extract_fg('User3')
  execute 'highlight User5 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': l:bg,
        \   'term': 'bold'
        \ })

  " Right-hand side section + italic (used for %).
  execute 'highlight User6 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': l:bg,
        \   'term': 'bold,italic'
        \ })

  highlight clear StatusLineNC
  highlight! link StatusLineNC User1
endfunction

function! FocusStatusline() abort
  if has("statusline")
    setlocal statusline=%5*
    setlocal statusline+=\ %{get(mode_map,mode())}
    setlocal statusline+=\ 
    setlocal statusline+=%3*
    setlocal statusline+=
    setlocal statusline+=%8*
    setlocal statusline+=\ %f
    setlocal statusline+=%=
    setlocal statusline+=%#CocWarningSign#
    setlocal statusline+=%{CoCWarnings()}
    setlocal statusline+=%8*
    setlocal statusline+=\ 
    setlocal statusline+=%#CocErrorSign#
    setlocal statusline+=%{CoCErrors()}
    setlocal statusline+=%8*
    setlocal statusline+=\ %y\ 
    setlocal statusline+=%3*
    setlocal statusline+=
    setlocal statusline+=%5*
    setlocal statusline+=\ %l,
    setlocal statusline+=\ %c
    setlocal statusline+=\ 
  endif
endfunction

function! BlurStatusLine() abort
  if has("statusline")
    setlocal statusline=%8*
    setlocal statusline+=\ %{get(mode_map,mode())}
    setlocal statusline+=\ 
    setlocal statusline+=\ 
    setlocal statusline+=\ %f
    setlocal statusline+=%=
    setlocal statusline+=%{CoCWarnings()}
    setlocal statusline+=%8*
    setlocal statusline+=\ 
    setlocal statusline+=%{CoCErrors()}
    setlocal statusline+=%8*
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
    autocmd FocusGained,BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call UpdateHighlight()
  else
    autocmd FocusGained,BufWinEnter,BufWritePost,FileWritePost,WinEnter * call FocusStatusline()
    autocmd FocusGained,BufWinEnter,BufWritePost,FileWritePost,WinEnter * call UpdateHighlight()
  endif
  autocmd FocusLost,WinLeave * call BlurStatusLine()
augroup END
