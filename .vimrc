" Setup
let g:name="Rasmus Bergström"
set nocompatible              " be improved, required
set shell=/bin/bash
execute pathogen#infect()
colorscheme afterglow
" Basic options
set mouse=a
set encoding=utf-8
set relativenumber
set noswapfile
set number
set modelines=0
set autoindent
set ignorecase
set smartcase
set smartindent
set showmatch
set incsearch
set ruler
set list
set listchars=tab:>-
set showcmd
set hlsearch
set showmatch
set formatoptions+=r
set formatoptions+=o
set pastetoggle=<F2>
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap
set textwidth=79
set formatoptions=qrn1j
set colorcolumn=+1
set hidden
" Airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set t_Co=256
" Matchit
runtime macros/matchit.vim
" Vundle
set rtp+=~/.vim/bundle/Vundle.vim " Runtimepath
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'Valloric/YouCompleteMe'
Plugin 'alessioalex/syntastic-local-tslint.vim'
call vundle#end()            " required
" Syntax checking & Omnicompletion
" General
set omnifunc=syntaxcomplete#Complete
syntax enable
filetype plugin indent on
set dictionary=/usr/share/dict/words
set fo+=t
set fo-=l
set completeopt=longest,menuone,preview
set splitbelow
set noshowmatch
let g:AutoPairsShortcutFastWrap=''
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
" C#
let g:syntastic_cs_checkers = ["syntax", "semantic", "issues"]
let g:OmniSharp_timeout = 1
" Typescript
autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
let g:syntastic_typescript_checkers = ["tsuquyomi", "tslint"]
let g:tslint_configs = [ 'tslint-config-standard', '~/2_school/3_y/2_lp/wheretrip/client/tslint.json' ]
let g:tsuquyomi_disable_quickfix = 1
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
au filetype typescript nnoremap <leader>q :SyntasticCheck<cr>
" Javascript
let g:syntastic_javascript_checkers = ["eslint"]
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:ycm_server_log_level = "debug"
" Mappings
" Leader
let mapleader = ";"
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
map <Leader>a :set invcursorline<cr>:set invcursorcolumn<cr>
map <Leader>i ^]
map <Leader>, ~
map <Leader>f :find
map <Leader>d :Ex<CR>
map <Leader>o :browse oldfiles<cr>
map <Leader>b :b
map <Leader>w :%s/ $//g<cr>
" Buffers
 "To open a new empty buffer
 nmap <leader>T :enew<cr>
 "Move to the next buffer
 nmap <leader>l :bnext<CR>
 " Move to the previous buffer
 nmap <leader>h :bprevious<CR>
 "Close the current buffer and move to the previous one
 " This replicates the idea of closing a tab
 nmap <leader>bq :bp <BAR> bd #<CR>
 "Show all open buffers and their status
 nmap <leader>bl :ls<CR>
" Dotfiles
:command Vrc e ~/.vimrc<cr>
:command Brc e ~/.bashrc<cr>
" Split Screen
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap c<C-j> :bel sp new<cr>
nnoremap c<C-k> :abo sp new<cr>
nnoremap c<C-h> :lefta vsp new<cr>
nnoremap c<C-l> :rightb vsp new<cr>
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c
" F9
" Python
autocmd FileType python nnoremap <buffer> <F9> :w<cr> :exec "!python" shellescape(@%, 1)<cr>
" C#
autocmd FileType cs nnoremap <buffer> <F9> :exec "!dotnet run" <cr>
" Searching in file
nnoremap / /\v
nnoremap n nzzzv
nnoremap N Nzzzv
" Other remaps
nnoremap <Leader>j :m+<CR>==
nnoremap <Leader>k :m--<CR>==
vnoremap <Leader>j :m '>+1<CR>gv=gv
vnoremap <Leader>k :m '<-2<CR>gv=gv
map H ^
map L $
nnoremap K kJ
nnoremap <Space> za
map <tab> %
" Extended Text Objects
let pairs =   { "<bar>" : "<bar>",
              \  ":" : ":" ,
              \  "." : "." ,
              \  "$" : "$" ,
              \  "," : "," ,
              \  "/" : "/" ,
              \  "<" : ">" ,
              \  "\\" : "\\",
              \  "*" : "*" ,
              \  "_" : "_" ,}


for [key, value] in items(pairs)
  exe "nnoremap di".value." T".key."dt".value
  exe "nnoremap da".value." F".key."df".value
  exe "nnoremap ci".value." T".key."ct".value
  exe "nnoremap ca".value." F".key."cf".value
  exe "nnoremap yi".value." T".key."yt".value
  exe "nnoremap ya".value." F".key."yf".value
  exe "nnoremap vi".value." T".key."vt".value
  exe "nnoremap va".value." F".key."vf".value
endfor
" Auto
au BufRead, BufNewFile *.j let comment=";"
" Autosave Folds
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent loadview
augroup END
" Resize splits
au VimResized * exe "normal! \<c-w>="
" NonVim Files
au BufRead *.pdf sil exe "!chr " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
