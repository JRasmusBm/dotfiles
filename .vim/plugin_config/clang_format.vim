Plug 'rhysd/vim-clang-format'

let g:clang_format#style_options = {
            \ 'BasedOnStyle': 'Google',
            \ 'ColumnLimit': 76,
            \ 'AccessModifierOffset' : -4,
            \ 'AllowShortIfStatementsOnASingleLine' : 'true',
            \ 'AlwaysBreakTemplateDeclarations' : 'true',
            \ 'Standard' : 'C++11' }
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>p :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>p :ClangFormat<CR>
au BufRead,BufNewFile *.c,*.h match BadWhitespace /\s\+$/
