" Setup
let g:name="Rasmus Bergström"
set nocompatible              " be improved, required
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
set gdefault
set showmatch
set formatoptions+=r
set formatoptions+=o
set pastetoggle=<F2>
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap
set textwidth=67
set formatoptions=qrn1j
set colorcolumn=+1
" File Browsing
" Wildmenu
set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

set wildignore+=*.luac                           " Lua byte code

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.orig                           " Merge resolution files

set wildignore+=*.fasl                           " Lisp FASLs

" Clojure/Leiningen
set wildignore+=classes
set wildignore+=lib
" Finding Files
set path+=**
" netrw
let g:netrw_bufsettings='noma nomod nu relativenumber nobl nowrap ro'
let g:netrw_banner=0
let g:netrw_preview=1
let g:netrw_winsize=25
let g:netrw_liststyle=3
" Powerline
set rtp+=/home/rasmus/.local/lib/python3.5/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256
" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" All of your Plugins must be added before the following line
Plugin 'Valloric/YouCompleteMe'
Plugin 'Valloric/MatchTagAlways'
Plugin 'mxm/vim-jsx'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp' : '/home/rasmus/.local/lib/python3.5/site-packages/powerline/bindings/vim/'}
call vundle#end()            " required
"Bundle "lepture/vim-jinja"
" Syntax
let g:AutoPairsShortcutFastWrap=''
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:syntastic_javascript_checkers = ["eslint"]
let g:ycm_server_log_level = "debug"
execute pathogen#infect()
filetype plugin indent on
syntax on 
" Mappings
" Leader
let mapleader = ";"
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
map <Leader>i ^]
map <Leader>, ~
map <Leader>f :find 
map <Leader>d :Ex<CR>
map <Leader>o :browse oldfiles<cr>
map <Leader>b :b 
" Dotfiles
:command Vrc e ~/.vimrc
:command Brc e ~/.bashrc
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
augroup nonvim 
    au!
    " au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls*,*.scpt sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
    " au BufRead *.ppt*,*.doc*,*.rtf sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
    au BufRead *.ppt*,*.doc*,*.rtf let g:output_pdf = shellescape(expand("%:r") . ".pdf")
    au BufRead *.ppt*,*.doc*,*.rtf sil exe "!$HOME/.bin/pdf " . shellescape(expand("%:p"))
    au BufRead *.ppt*,*.doc*,*.rtf sil exe "!xdg-open " . g:output_pdf | bd | let &ft=&ft | redraw!
    au BufRead *.pdf sil exe "!zathura " . expand("%:p") | bd | let &ft=&ft | redraw!
augroup end
" Autosave Folds
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent loadview
augroup END
" Resize splits
au VimResized * exe "normal! \<c-w>="
