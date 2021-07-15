if has('nvim')
else
  let g:OmniSharp_timeout = 1
endif

nnoremap <buffer> <F9> :exec "!dotnet run" <cr>
