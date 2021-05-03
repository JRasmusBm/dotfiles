source ~/.vim/snippets/lua.vim

call jrasmusbm#lsp#setup_maps()

nnoremap <buffer> <localleader>tf :luafile %
