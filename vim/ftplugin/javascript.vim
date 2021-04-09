let b:ale_fixers = ['prettier', 'eslint']

source ~/.vim/snippets/css.vim
source ~/.vim/snippets/html.vim
source ~/.vim/snippets/graphql.vim
source ~/.vim/snippets/javascript.vim

call jrasmusbm#coc#setup_maps()
command! Lint cex system("npm run lint -- --format=unix") <Bar> copen
