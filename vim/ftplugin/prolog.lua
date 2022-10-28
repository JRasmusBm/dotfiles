require("jrasmusbm.utils").ensure_setup("prolog.vim")

vim.cmd [[
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/prolog.vim"
setlocal foldmethod=marker
]]
