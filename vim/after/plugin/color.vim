function s:CheckColorScheme()
  if !has('termguicolors')
    let g:base16colorspace=256
  endif

  let s:config_file = expand('~/.current-theme')
  if has("nvim")
    let s:plugin_path="~/.local/share/nvim/site/pack/"
  else
  endif

  if filereadable(s:config_file)
    let s:config = readfile(s:config_file, '', 2)

    if s:config[1] =~# '^dark\|light$'
      execute 'set background=' . s:config[1]
    else
      echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
    endif
    let s:base_16_vim_config=expand(s:plugin_path . 'base16/start/base16-vim/colors/base16-' . s:config[0] . '.vim')
    if filereadable(s:base_16_vim_config)
      execute 'color base16-' . s:config[0]
    else
      echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
    endif
  else " default
    set background=dark
    color base16-default-dark
  endif

  execute 'highlight Comment ' . pinnacle#italicize('Comment')
  call ErrorHighlights()
  call SpellingHighlights()
  call SearchHighlights()
  call FoldHighlights()
  call CocHighlights()
endfunction

function! FoldHighlights() abort
  highlight Folded guibg=NONE guifg=darkyellow
  highlight FoldColumn guibg=darkgrey guifg=white
endfunction

function! ErrorHighlights() abort
  highlight Error guifg=red guibg=NONE
  highlight BadWhitespace guibg=darkred
endfunction

function! SearchHighlights() abort
  highlight Search guifg=yellow guibg=NONE
endfunction

function! HighlightMarker() abort
  highlight SnippetMarker guifg=yellow guibg=NONE
  match SnippetMarker /<++>/
endfunction

function! SpellingHighlights() abort
  highlight SpellBad guifg=teal guibg=NONE 
  highlight SpellCap guifg=teal guibg=NONE 
  highlight SpellLocal guifg=teal guibg=NONE 
  highlight SpellRare guifg=teal guibg=NONE 
endfunction

function! CocHighlights() abort
  highlight CocErrorHighlight guifg=red guibg=NONE gui=undercurl term=undercurl
  highlight CocErrorSign guifg=red guibg=NONE 
  highlight CocWarningHighlight guifg=yellow guibg=NONE gui=undercurl term=undercurl
  highlight CocWarningSign guifg=yellow guibg=NONE 
  highlight CocUnderline gui=undercurl term=undercurl
endfunction

if v:progname !=# 'vi'
  if has('autocmd')
    augroup UpdateColorScheme
      autocmd!
      autocmd FocusGained * call s:CheckColorScheme()
    augroup END
  endif

  call s:CheckColorScheme()
endif
