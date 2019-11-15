function s:CheckColorScheme()
  if !has('termguicolors')
    let g:base16colorspace=256
  endif

  let s:config_file = expand('~/.current-theme')

  if filereadable(s:config_file)
    let s:config = readfile(s:config_file, '', 2)

    if s:config[1] =~# '^dark\|light$'
      execute 'set background=' . s:config[1]
    else
      echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
    endif

    let s:base_16_vim_config=expand(g:plugin_path . '/base16-vim/colors/base16-' . s:config[0] . '.vim')
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