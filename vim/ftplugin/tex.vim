packadd! Latex-Text-Formatter

nnoremap <buffer> <Leader>p <ESC>:call FormatLatexPar(0)<CR>
vnoremap <buffer> <Leader>p <ESC>:call FormatLatexPar(0)<CR>
nnoremap <buffer>  <ESC>:LLPStartPreview<CR>

set textwidth=60

match BadWhitespace /\s\+$/

setlocal spell spelllang=en_us

execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/latex.vim"
