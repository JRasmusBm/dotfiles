function! jrasmusbm#coc#setup_maps() abort
  nmap <buffer> <leader>a :CocAction
  nmap <buffer> K :call CocAction("doHover")
  nmap <buffer> g/ :call CocAction("rename")
  nmap <buffer> Q :call CocAction("format")
  vmap <buffer> Q :call CocAction("formatSelected")
  nmap <buffer> <c-]> <Plug>(coc-definition)
  nmap <buffer> gt <Plug>(coc-type-definition)
  nmap <buffer> gD <Plug>(coc-implementation)
  nmap <buffer> gr <Plug>(coc-references)
  nmap <buffer> [v <Plug>(coc-diagnostic-prev-error)
  nmap <buffer> ]v <Plug>(coc-diagnostic-next-error)
  nmap <buffer> [V <Plug>(coc-diagnostic-prev)
  nmap <buffer> ]V <Plug>(coc-diagnostic-next)
  inoremap <buffer><silent><expr> <c-space> coc#refresh()
endfunction

