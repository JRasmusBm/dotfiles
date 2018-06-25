" Setup
let g:name="Rasmus Bergström"
set nocompatible              " be improved, required
set shell=/bin/zsh
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
set fileformat=unix
set list
set listchars=tab:>-
set showcmd
set hlsearch
set showmatch
set pastetoggle=<F2>
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap
set textwidth=79
set formatoptions=qrn1jo
set colorcolumn=+1
set signcolumn=yes
set hidden
let $BASH_ENV="~/.zshenv"
" netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_menu = 0
let g:netrw_banner = 0
" Airline
let g:airline#extensions#tabline#enabled = 1
" TmuxLine
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
" PromptLine
let g:promptline_theme = 'airline'
set laststatus=2
set t_Co=256
" Vundle
set rtp+=~/.vim/bundle/Vundle.vim " Runtimepath
call vundle#begin()
Plugin 'Konfekt/FastFold'
Plugin 'Latex-Text-Formatter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'gregsexton/gitv'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'tmhedberg/matchit'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'powerline/powerline'
Plugin 'edkolev/promptline.vim'
Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'alessioalex/syntastic-local-tslint.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'Ron89/thesaurus_query.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'
Plugin 'SirVer/ultisnips'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rhysd/vim-clang-format'
Plugin 'tpope/vim-commentary'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'tpope/vim-endwise'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'takac/vim-hardtime'
Plugin 'ivanov/vim-ipython'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'mxw/vim-jsx'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'sickill/vim-pasta'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
Plugin 'tpope/vim-repeat'
Plugin 'honza/vim-snippets'
Plugin 'styled-components/vim-styled-components'
Plugin 'tpope/vim-surround'
Plugin 'heavenshell/vim-tslint-config'
Plugin 'ianks/vim-tsx'
Plugin 'tpope/vim-unimpaired'
Plugin 'nixon/vim-vmath'
Plugin 'rhysd/vim-wasm'
Plugin 'mindriot101/vim-yapf'
Plugin 'Shougo/vimproc.vim'
Plugin 'VundleVim/Vundle.vim'
call vundle#end()            " required
" Syntax checking & completion
" General
syntax enable
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview
set splitbelow
set noshowmatch
let g:AutoPairsShortcutFastWrap=''
" Statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" Dictionary
set dictionary=/usr/share/dict/words
" Format options (Text width)
set fo+=tc
set fo-=l
" Syntastic
highlight SyntasticError ctermfg=darkred
highlight SyntasticWarning ctermfg=darkyellow
highlight SyntasticErrorSign ctermfg=darkred
highlight SyntasticWarningSign ctermfg=darkyellow
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_highlighting=1
let g:syntastic_enable_signs=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = "\u2717"
let g:syntastic_warning_symbol = "\u2717"
" clang
let g:clang_format#style_options = {
            \ "BasedOnStyle": "Google",
            \ "ColumnLimit": 76,
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11" }
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>p :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>p :ClangFormat<CR>
" Latex
autocmd Filetype plaintex,context,tex nnoremap <Leader>p <ESC>:call FormatLatexPar(0)<CR>i
" C#
let g:syntastic_cs_checkers = ["syntax", "semantic", "issues"]
let g:OmniSharp_timeout = 1
" Javascript
let g:syntastic_javascript_checkers = ["eslint"]
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:ycm_server_log_level = "debug"
let g:ycm_filetype_blacklist = { "vim": 1 }

" Typescript
let g:syntastic_typescript_checkers = ["tsuquyomi", "tslint"]
let g:tslint_configs = [ 'tslint-config-standard', '~/2_school/3_y/2_lp/wheretrip/client/tslint.json' ]
let g:tsuquyomi_disable_quickfix = 1
" Markdown
let vim_markdown_preview_hotkey='<C-p>'
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1
" Python
highlight BadWhitespace ctermbg=darkred
autocmd FileType python :nnoremap <leader>p :call Yapf()<CR>
let g:yapf_style = "pep8"
let g:ycm_python_binary_path = '/usr/bin/python3.6'
let python_highlight_all=1
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
" Mappings
" Leader
let mapleader = ";"
nnoremap <C-s> <C-a>
" fzf
nnoremap <Leader>ff :Files .<CR>
nnoremap <Leader>fgf :GFiles<CR>
nnoremap <Leader>fgs :GFiles?<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>fw :Windows<CR>
nnoremap <Leader>fhf :History<CR>
nnoremap <Leader>fhc :History:<CR>
nnoremap <Leader>fhs :History/<CR>
nnoremap <Leader>fs :Snippets<CR>
nnoremap <Leader>fco :Commits<CR>
nnoremap <Leader>fcm :Commands<CR>
nnoremap <Leader>fm :Maps<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fp :Filetypes<CR>
" Source
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
nnoremap <leader>s  :call VMATH_Analyse()<CR>
vnoremap <leader>s  y:call VMATH_Analyse()<CR>
nnoremap <leader>r !!sh<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <Leader>a :set invcursorline<cr>:set invcursorcolumn<cr>
nnoremap <Leader>i ^]
nnoremap <Leader>, ~
nnoremap <Leader>d :Ex<CR>
nnoremap <Leader>b :%!xxd<cr>
nnoremap <Leader>w :%s/ $//g<cr>
nnoremap <Leader>n :call QuitNetrw()<cr>
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
:command! Vrc e ~/.vimrc<cr>
:command! Brc e ~/.bashrc<cr>
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
" Typescript
autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
au filetype typescript nnoremap <leader>q :SyntasticCheck<cr>
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
" Folds
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
let g:markdown_folding = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent loadview
augroup END
" Flag unneccesary whitespace 
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" Resize splits
au VimResized * exe "normal! \<c-w>="
au FileType gitcommit set tw=72
" NonVim Files
au BufRead *.pdf sil exe "!chr " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
autocmd BufNewFile,BufRead *.wast call WasmSetOptions() WasmSetOptions()
function! WasmSetOptions()
  set softtabstop=0
  set expandtab
  set tabstop=2
  set shiftwidth=2
endfunction
function! QuitNetrw()
  for i in range(1, bufnr('$'))
    if buflisted(i)
      if getbufvar(i, '&filetype') == "netrw"
        silent exe 'bwipeout ' . i
      endif
    endif
  endfor
endfunction
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 2

