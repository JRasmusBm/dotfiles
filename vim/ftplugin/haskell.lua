vim.cmd [[
setlocal foldmethod=marker
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/haskell.vim"
]]

require("jrasmusbm.utils").ensure_setup "ghcmod-vim"
