let b:ale_fixers = ['prettier', 'eslint', 'tslint']
nnoremap <Leader>r <Plug>(TsuquyomiRenameSymbol)
nnoremap <buffer> <leader>cd :TSDoc

source ~/.vim/snippets/css.vim
source ~/.vim/snippets/html.vim
source ~/.vim/snippets/graphql.vim
source ~/.vim/snippets/javascript.vim
source ~/.vim/snippets/typescript.vim

call jrasmusbm#coc#setup_maps()
nmap <buffer> Q :CocCommand eslint.executeAutofix
