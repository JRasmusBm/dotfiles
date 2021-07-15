source ~/.vim/snippets/css.vim
source ~/.vim/snippets/html.vim
source ~/.vim/snippets/graphql.vim
source ~/.vim/snippets/javascript.vim

command! Lint cex system("npm run lint -- --format=unix") <Bar> copen
