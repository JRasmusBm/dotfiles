packadd! Latex-Text-Formatter

nnoremap <buffer> <Leader>p <ESC>:call FormatLatexPar(0)<CR>
vnoremap <buffer> <Leader>p <ESC>:call FormatLatexPar(0)<CR>
nnoremap <buffer>  <ESC>:LLPStartPreview<CR>

set textwidth=60

match BadWhitespace /\s\+$/

setlocal spell spelllang=en_us

source ~/.vim/snippets/latex.vim
