function! jrasmusbm#plugin#lazy(config) abort
  let l:id=a:config.pack . '::' . a:config.plugin
  let s:plugins[l:id]=a:config
  let l:load='call <SID>load("' . l:id . '")'
  if has_key(a:config, 'commands')
    for l:command in items(a:config.commands)
      let l:deletions=map(keys(a:config.commands), '"delcommand " . v:val')
      execute 'command! ' .
            \ l:command[1] . ' ' .
            \ l:command[0] . ' ' .
            \ ':' . join(l:deletions, ' <bar> ') . ' <bar> ' .
            \ l:load . ' <bar> ' .
            \ l:command[0] .
            \ ' <args>'
    endfor
  endif
  if has_key(a:config, 'nnoremap')
    for l:mapping in items(a:config.nnoremap)
      execute 'nnoremap ' .
        \ l:mapping[0] . ' ' .
        \ ':' . l:load . '<CR>' .
        \ l:mapping[1]
    endfor
  endif
endfunction
