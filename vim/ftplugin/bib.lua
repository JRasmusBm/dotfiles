vim.cmd[[
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/bib.vim"

nnoremap <buffer> ;af gg:%! bibclean -no-check-valueszz
]]
