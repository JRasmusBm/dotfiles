let b:ale_fixers = ['prettier', 'eslint', 'tslint']
nnoremap <Leader>r <Plug>(TsuquyomiRenameSymbol)

source ~/.vim/snippets/css.vim
source ~/.vim/snippets/html.vim
source ~/.vim/snippets/javascript.vim
source ~/.vim/snippets/typescript.vim
source ~/.vim/snippets/graphql.vim

call jrasmusbm#lsp#setup_maps()
nmap <buffer> Q :CocCommand eslint.executeAutofix
