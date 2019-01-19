" Setup {{{{{{
let g:name='Rasmus Bergström'
set background=dark
set termguicolors
syntax enable
set nocompatible
set mouse=a
set encoding=utf-8
set noswapfile
set fileformat=unix
set hidden
set modelines=0
set viewoptions=cursor,folds,slash,unix
set hlsearch
set showmatch
set ignorecase
set smartcase
set incsearch
set timeoutlen=300 ttimeoutlen=0
" }}}}}}

" Plugins {{{

" Plug {{{

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'jceb/vim-orgmode'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'mileszs/ack.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Konfekt/FastFold'
Plug 'jrasmusbm/Latex-Text-Formatter'
Plug 'tmhedberg/SimpylFold'
Plug 'Olical/vim-enmasse'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'zchee/deoplete-jedi'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
else
  Plug 'leafgarland/typescript-vim'
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'TaDaa/vimade'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'gregsexton/gitv'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-scripts/Align'
Plug 'b4b4r07/vim-sqlfmt'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'tmhedberg/matchit'
Plug 'edkolev/promptline.vim'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'alessioalex/syntastic-local-tslint.vim'
Plug 'vim-syntastic/syntastic'
Plug 'Ron89/thesaurus_query.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'Quramy/tsuquyomi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'hail2u/vim-css3-syntax'
Plug 'tpope/vim-endwise'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jparise/vim-graphql'
Plug 'takac/vim-hardtime'
Plug 'ivanov/vim-ipython'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'sickill/vim-pasta'
Plug 'w0rp/ale'
Plug 'tpope/vim-repeat'
Plug 'zhimsel/vim-stay'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tpope/vim-surround'
Plug 'heavenshell/vim-tslint-config'
Plug 'ianks/vim-tsx'
Plug 'tpope/vim-unimpaired'
Plug 'nixon/vim-vmath'
Plug 'rhysd/vim-wasm'
Plug 'ambv/black'
Plug 'Shougo/vimproc.vim'
Plug 'VundleVim/Vundle.vim'
call plug#end()
call glaive#Install()
" }}}

" netrw {{{
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_menu = 0
let g:netrw_banner = 0
" }}}

" Hardtime {{{
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 2
"}}}

" }}}

" Layout {{{
colorscheme jellybeans
set relativenumber
set number
set showcmd
set list
set listchars=tab:>-
set signcolumn=yes
set ruler
set laststatus=2

" Vimade {{{
let g:vimade = {
  \ 'normalid': '',
  \ 'basefg': '',
  \ 'basebg': '',
  \ 'fadelevel': 0.8,
  \ 'colbufsize': 30,
  \ 'rowbufsize': 30,
  \ 'checkinterval': 32,
  \ }
" }}}

" Error Styling{{{
highlight Error ctermfg=darkred ctermbg=NONE
highlight BadWhitespace ctermbg=darkred

" Spelling {{{
highlight SpellBad ctermfg=darkred ctermbg=NONE
highlight SpellCap ctermfg=darkred ctermbg=NONE
highlight SpellLocal ctermfg=darkred ctermbg=NONE
highlight SpellRare ctermfg=darkred ctermbg=NONE
"}}}

" Syntastic {{{
highlight SyntasticError ctermfg=darkred
highlight SyntasticWarning ctermfg=darkyellow
highlight SyntasticErrorSign ctermfg=darkred
highlight SyntasticWarningSign ctermfg=darkyellow
" }}}
" }}}

" General {{{
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview
set splitbelow
set noshowmatch
" }}}

" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_exclude_previous=0
let airline#extensions#syntastic#error_symbol = 'E:'
let airline#extensions#syntastic#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#syntastic#warning_symbol = 'W:'
let airline#extensions#syntastic#stl_format_warn = '%W{[%w(#%fw)]}'
" }}}

" TmuxLine {{{
let airline#extensions#tmuxline#snapshot_file = '~/.tmux-status.conf'
" }}}

" }}}

" Formatting {{{

" General {{{
filetype plugin indent on
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap
set textwidth=79
set formatoptions=qrn1jo
set colorcolumn=+1
set fo+=tc
set fo-=l
" }}}

" Language Specific {{{

" bib {{{
autocmd FileType bib let b:ale_fixers = ['bibclean']
" }}}

" clang {{{
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
" }}}

" Python {{{
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
" }}}

" Python {{{
let g:sqlfmt_command='sqlfmt'
let g:sqlfmt_auto=0
" }}}

" Git Commit {{{
au FileType gitcommit set textwidth=72
" }}}

" NonVim Files {{{
au BufRead *.pdf sil exe '!chr ' . shellescape(expand('%:p')) | bd | let &ft=&ft | redraw!
"}}}

" WebAssembly {{{
autocmd BufNewFile,BufRead *.wast call WasmSetOptions() WasmSetOptions()
function! WasmSetOptions()
  set softtabstop=0
  set expandtab
  set tabstop=2
  set shiftwidth=2
endfunction
" }}}

" vim {{{
autocmd FileType vim setlocal foldmethod=marker
" }}}

" Markdown
autocmd FileType markdown set tabstop=4
autocmd FileType markdown set shiftwidth=4
autocmd FileType markdown set softtabstop=4
" }}}

" }}}

" Syntax Checking & completion {{{

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
"}}}

" Syntastic {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_highlighting=1
let g:syntastic_enable_signs=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = '\u2717'
let g:syntastic_warning_symbol = '\u2717'
" }}}

" FileTypes {{{

" Jasmin {{{
au BufRead, BufNewFile *.j let comment=';'
" }}}

" Latex {{{
" }}}

" C# {{{
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
if has('nvim')
else
  let g:OmniSharp_timeout = 1
endif
" }}}

" Javascript {{{
autocmd FileType javascript let b:ale_fixers = ['prettier', 'eslint']
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" }}}

" Typescript {{{
autocmd FileType typescript let b:ale_fixers = ['prettier', 'tslint']
" }}}

" Vue {{{
autocmd FileType vue let b:ale_fixers = ['prettier']
" }}}

" Markdown {{{
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1
autocmd FileType markdown let b:ale_fixers = ['prettier']
" }}}

" Python {{{
let g:black_fast = 0
let g:black_linelength = 76
let g:black_skip_string_normalization = 0
let python_highlight_all=1
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
" }}}
" }}}

" }}}

" Mappings {{{

" Leader {{{
let mapleader = ';'
nmap ö ;
" }}}

" Snippets {{{
highlight MyGroup ctermfg=yellow
match MyGroup /<++>/
nnoremap <Leader>es :Files ~/.vim/snippets/<CR>

" Helper Functions {{{
function! BackwardMarker(n)
  if a:n > 0
    execute 'normal! ?<++> '  . a:n . 'n\"_d4l'
  else
    execute 'normal! ?<++>\"_d4l'
  endif
  execute 'startinsert'
endfunction
function! ForwardMarker(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n\"_d4l'
  else
    execute 'normal! /<++>\"_d4l'
  endif
  execute 'startinsert'
endfunction
function! DeleteMarker(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n\"_d4l'
  else
    execute 'normal! /<++>\"_d4l'
  endif
endfunction
function! DeleteMarkerRow(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n\"_dd'
  else
    execute 'normal! /<++>\"_dd'
  endif
endfunction
" }}}

" File Types {{{
autocmd FileType sql source ~/.vim/snippets/sql.vim
autocmd FileType bib source ~/.vim/snippets/bib.vim
autocmd FileType python source ~/.vim/snippets/python.vim
autocmd FileType html,htmldjango,javascript,typescript source ~/.vim/snippets/html.vim
autocmd FileType html,htmldjango,javascript,typescript,css source ~/.vim/snippets/css.vim
autocmd FileType java source ~/.vim/snippets/java.vim
autocmd FileType markdown source ~/.vim/snippets/markdown.vim
autocmd FileType plaintex,context,tex source ~/.vim/snippets/latex.vim
autocmd FileType javascript,typescript,json source ~/.vim/snippets/javascript.vim
autocmd FileType typescript source ~/.vim/snippets/typescript.vim
autocmd FileType vim source ~/.vim/snippets/vim.vim
autocmd FileType vue source ~/.vim/snippets/vue.vim
autocmd FileType vue source ~/.vim/snippets/javascript.vim
autocmd FileType vue source ~/.vim/snippets/typescript.vim
autocmd FileType vue source ~/.vim/snippets/html.vim
" }}}

" Movement {{{
inoremap ;dd :call DeleteMarkerRow(1)
inoremap ;dm :call DeleteMarker(1)
nnoremap ;dd :call DeleteMarkerRow(1)
nnoremap ;dm :call DeleteMarker(1)
inoremap ;G :call BackwardMarker(1)
nnoremap <Leader>G :call BackwardMarker(1)
inoremap ;g :call ForwardMarker(1)
nnoremap <Leader>g :call ForwardMarker(1)
" }}}
" }}}

" Fuzzy Finder (fzf) {{{
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
nnoremap <Leader>fco :Commits<CR>
nnoremap <Leader>fcm :Commands<CR>
nnoremap <Leader>fm :Maps<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fp :Filetypes<CR>
" }}}

" Source {{{
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
" }}}

" Language {{{
nnoremap <leader>ce :setlocal spell spelllang=en_us<CR>
nnoremap <leader>cv :setlocal spell spelllang=sv<CR>
nnoremap <leader>cc :set nospell<CR>
inoremap ;sy b:ThesaurusQueryReplaceCurrentWord<CR>
" }}}

" Plugins {{{

" Statistics {{{
nnoremap <leader>st  :call VMATH_Analyse()<CR>
vnoremap <leader>st  y:call VMATH_Analyse()<CR>
" }}}
" }}}

" Buffer Navigation {{{
 nmap <leader>T :enew<cr>
 nmap <leader>bd :bp! <BAR> bd #<CR>
 nmap <leader>bl :ls<CR>
 " }}}

" Dotfiles {{{
:command! Vrc e ~/.vimrc
:command! Nrc e ~/.config/nvim/init.vim
:command! Brc e ~/.bashrc
:command! Zrc e ~/.zshrc
:command! Zenv e ~/.zshenv
" }}}

" Split Screen {{{
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap c<C-j> :bel sp new<cr>
nnoremap c<C-k> :abo sp new<cr>
nnoremap c<C-h> :lefta vsp new<cr>
nnoremap c<C-l> :rightb vsp new<cr>
nnoremap m<C-j> :bel sp %<cr>
nnoremap m<C-k> :abo sp %<cr>
nnoremap m<C-h> :lefta vsp %<cr>
nnoremap m<C-l> :rightb vsp %<cr>
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c
" }}}

" FileType Specific {{{

" Typescript {{{
autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
" }}}

" Markdown {{{
let vim_markdown_preview_hotkey='<C-p>'
" }}}

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

" Extended Text Objects {{{

let pairs =   { '<bar>' : '<bar>',
              \  ':' : ':' ,
              \  '.' : '.' ,
              \  '$' : '$' ,
              \  ',' : ',' ,
              \  '/' : '/' ,
              \  '<' : '>' ,
              \  '\\' : '\\',
              \  '*' : '*' ,
              \  '_' : '_' ,}

for [key, value] in items(pairs)
  exe 'nnoremap di'.value.' T'.key.'dt'.value
  exe 'nnoremap da'.value.' F'.key.'df'.value
  exe 'nnoremap ci'.value.' T'.key.'ct'.value
  exe 'nnoremap ca'.value.' F'.key.'cf'.value
  exe 'nnoremap yi'.value.' T'.key.'yt'.value
  exe 'nnoremap ya'.value.' F'.key.'yf'.value
  exe 'nnoremap vi'.value.' T'.key.'vt'.value
  exe 'nnoremap va'.value.' F'.key.'vf'.value
endfor
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
nnoremap ]p :ALENext
nnoremap [p :ALEPrevious
nnoremap ;zc :call CloseFolds()
nnoremap ;zo :call OpenFolds()
nnoremap <leader>p :ALEFix
nnoremap <C-s> <C-a>
nnoremap <leader>rc !!sh<CR>
nnoremap K kJ
nnoremap <Leader>ac :set invcursorline<cr>:set invcursorcolumn<cr>
nnoremap <Leader>d :Ex<CR>
nnoremap <Leader>bf :%!xxd<cr>
nnoremap <Leader>ws :%s/ $//g<cr>:noh
nnoremap <Leader>wl :v/\S/d<cr>:noh
nnoremap <leader>cp :SyntasticCheck<cr>
nnoremap <leader>pp :SyntasticToggleMode<cr>
" }}}
" }}}

" Folds {{{
nnoremap <Space> za
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 0
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
" }}}

" Resize splits {{{
au VimResized * exe 'normal! \<c-w>='
" }}}
