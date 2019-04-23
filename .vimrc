" Most of this file is a direct copy of @ChrisToomey's vimrc. His organization
" really spoke to me so I decided that imitation is the greatest form of
" flattery.

if !has('nvim') 
  set nocompatible
endif

" Need to set the leader before defining any leader mappings
let mapleader = ';'
" In case I am using Scandinavian Keyboard (Breaks most cases anyways)
nmap ö ; 

function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

if !has('nvim') 
  call plug#begin('~/.vim/bundle')
else
  call plug#begin('~/.local/share/nvim/plugged')
endif
call s:SourceConfigFilesIn('plugin_config')
call plug#end()

call s:SourceConfigFilesIn('other_config')

" FileType Specific {{{

" Latex {{{
autocmd Filetype plaintex,context,tex nnoremap <buffer> <Leader>p <ESC>:call FormatLatexPar(0)<CR>
autocmd Filetype plaintex,context,tex vnoremap <buffer> <Leader>p <ESC>:call FormatLatexPar(0)<CR>
autocmd Filetype plaintex,context,tex nnoremap <buffer>  <ESC>:LLPStartPreview<CR>
" }}}

" Python {{{
autocmd FileType python :nnoremap <buffer> <leader>p :Black<CR>
autocmd FileType python nnoremap <buffer>  :w<cr> :exec '!python' shellescape(@%, 1)<cr>
" }}}


" sql {{{
autocmd FileType sql nnoremap <buffer> <leader>p :SQLFmt<cr>
" }}}

" Shell {{{
autocmd FileType sh,zsh nnoremap <buffer> <leader>p :FormatCode<cr>
" }}}

" Java {{{
autocmd FileType java nnoremap <buffer> <leader>p :FormatCode<cr>
" }}}

" C# {{{
autocmd FileType cs nnoremap <buffer> <F9> :exec "!dotnet run" <cr>
" }}}
" }}}

" Center Cursor {{{
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz
nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap n nzzzv
vnoremap N Nzzzv
" }}}

" Move line {{{
nnoremap <Leader>j :m+<CR>==
nnoremap <Leader>k :m--<CR>==
vnoremap <Leader>j :m '>+1<CR>gv=gv
vnoremap <Leader>k :m '<-2<CR>gv=gv
" }}}

" Delete Views {{{
function! MyDeleteView()
    let path = fnamemodify(bufname('%'),':p')
    " vim's odd =~ escaping for /
    let path = substitute(path, '=', '==', 'g')
    if empty($HOME)
    else
        let path = substitute(path, '^'.$HOME, '\~', '')
    endif
    let path = substitute(path, '/', '=+', 'g') . '='
    " view directory
    let path = &viewdir.'/'.path
    call delete(path)
    echo 'Deleted: '.path
endfunction
command! Delview call MyDeleteView()
"}}}

" Other Mappings {{{
function! UpdateX()
  let @x = @/[2:-3]
endfunction
function! CloseFolds()
  let save_pos = getpos('.')
  execute 'normal! ggVGzC'
  call setpos('.', save_pos)
endfunction
function! OpenFolds()
  let save_pos = getpos('.')
  execute 'normal! ggVGzO'
  call setpos('.', save_pos)
endfunction
nnoremap <leader>fi :EnMasse
nnoremap <leader>p :ALEFix
nnoremap <leader>cp :ALELint
nnoremap ]v :ALENext
nnoremap [v :ALEPrevious
nnoremap ;zc :call CloseFolds()
nnoremap ;zo :call OpenFolds()
nnoremap <leader>p :ALEFix
nnoremap <leader>rc !!sh<CR>
nnoremap K kJ
nnoremap <Leader>ac :set invcursorline<cr>:set invcursorcolumn<cr>
nnoremap <Leader>d :Ex
command! Dig h digraph-table
nnoremap <Leader>bf :%!xxd<cr>
nnoremap <Leader>ws :%s/ $//g<cr>:noh
nnoremap <Leader>wl :v/\S/d<cr>:noh
nnoremap * *:call UpdateX()
nnoremap # #:call UpdateX()
nnoremap <leader>? :call ale#cursor#ShowCursorDetail()
" }}}
" }}}

" Resize splits {{{
autocmd VimResized * exe 'normal! \<c-w>='
" }}}
