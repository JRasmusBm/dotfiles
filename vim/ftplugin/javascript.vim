execute "source $DOTFILES/vim/snippets/css.vim"
execute "source $DOTFILES/vim/snippets/html.vim"
execute "source $DOTFILES/vim/snippets/graphql.vim"
execute "source $DOTFILES/vim/snippets/javascript.vim"

command! Lint cex system("npm run lint -- --format=unix") <Bar> copen
