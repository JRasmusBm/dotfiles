nnoremap <buffer> <Leader>p <ESC>:call FormatLatexPar(0)<CR>
vnoremap <buffer> <Leader>p <ESC>:call FormatLatexPar(0)<CR>
nnoremap <buffer>  <ESC>:LLPStartPreview<CR>

setlocal spell spelllang=en_us

source ~/.vim/snippets/latex.vim
