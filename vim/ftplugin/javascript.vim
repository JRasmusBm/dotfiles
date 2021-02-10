let b:ale_fixers = ['prettier', 'eslint']

source ~/.vim/snippets/css.vim
source ~/.vim/snippets/html.vim
source ~/.vim/snippets/graphql.vim
source ~/.vim/snippets/javascript.vim

call jrasmusbm#coc#setup_maps()
nmap <buffer> Q :CocCommand eslint.executeAutofix
command! Lint cex system("npm run check:lint -- --format=unix") <Bar> copen
