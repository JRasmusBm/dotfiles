" Setup {{{{{{
let g:name="Rasmus Bergström"
syntax enable
set nocompatible
set shell=/bin/zsh
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

" Vundle {{{
set rtp+=~/.vim/bundle/Vundle.vim " Runtimepath
call vundle#begin()
Plugin 'mileszs/ack.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'Konfekt/FastFold'
Plugin 'Latex-Text-Formatter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'easymotion/vim-easymotion'
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
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'sickill/vim-pasta'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
Plugin 'tpope/vim-repeat'
Plugin 'zhimsel/vim-stay'
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
colorscheme afterglow
set background=dark
set relativenumber
set number
set showcmd
set list
set listchars=tab:>-
set signcolumn=yes
set ruler

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
let airline#extensions#syntastic#error_symbol = 'E:'
let airline#extensions#syntastic#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#syntastic#warning_symbol = 'W:'
let airline#extensions#syntastic#stl_format_warn = '%W{[%w(#%fw)]}'
" }}}

" TmuxLine {{{
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
" }}}

" PromptLine {{{
let g:promptline_theme = 'airline'
set laststatus=2
set t_Co=256
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

" clang {{{
let g:clang_format#style_options = {
            \ "BasedOnStyle": "Google",
            \ "ColumnLimit": 76,
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11" }
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>p :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>p :ClangFormat<CR>
au BufRead,BufNewFile *.c,*.h match BadWhitespace /\s\+$/
" }}}

" Python {{{
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
" }}}

" Git Commit {{{
au FileType gitcommit set textwidth=72
" }}}

" NonVim Files {{{
au BufRead *.pdf sil exe "!chr " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
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

" }}}

" }}}

" Syntax Checking & completion {{{

" Syntastic {{{
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
" }}}

" YCM {{{
let g:ycm_server_log_level = "debug"
let g:ycm_filetype_blacklist = { "vim": 1 }
" }}}

" FileTypes {{{

" Jasmin {{{
au BufRead, BufNewFile *.j let comment=";"
" }}}

" Latex {{{
let g:livepreview_previewer = 'mupdf'
let g:livepreview_previewer = 'pdflatex'
let g:syntastic_tex_checkers = ["lacheck", "chktex"]
" }}}

" C# {{{
let g:syntastic_cs_checkers = ["syntax", "semantic", "issues"]
let g:OmniSharp_timeout = 1
" }}}

" Javascript {{{
let g:syntastic_javascript_checkers = ["eslint"]
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" }}}

" Typescript {{{
let g:syntastic_typescript_checkers = ["tsuquyomi", "tslint"]
let g:tslint_configs = [ 'tslint-config-standard', '~/2_school/3_y/2_lp/wheretrip/client/tslint.json' ]
let g:tsuquyomi_disable_quickfix = 1
" }}}

" Markdown {{{
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1
" }}}

" Python {{{
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
" }}}
" }}}

" }}}

" Mappings {{{

" Leader {{{
let mapleader = ";"
nmap ö ;
" }}}

" Snippets {{{

highlight MyGroup ctermfg=yellow
match MyGroup /<++>/
nnoremap <Leader>es :Files ~/.vim/snippets/<CR>

" Helper Functions {{{
function! BackwardMarker(n)
  if a:n > 0
    execute "normal! ?<++> "  . a:n . "n\"_d4l"
  else
    execute "normal! ?<++>\"_d4l"
  endif
  execute "startinsert"
endfunction
function! ForwardMarker(n)
  if a:n > 1
    execute "normal! /<++> "  . (a:n - 1) . "n\"_d4l"
  else
    execute "normal! /<++>\"_d4l"
  endif
  execute "startinsert"
endfunction
function! DeleteMarker(n)
  if a:n > 1
    execute "normal! /<++> "  . (a:n - 1) . "n\"_d4l"
  else
    execute "normal! /<++>\"_d4l"
  endif
endfunction
function! DeleteMarkerRow(n)
  if a:n > 1
    execute "normal! /<++> "  . (a:n - 1) . "n\"_dd"
  else
    execute "normal! /<++>\"_dd"
  endif
endfunction
" }}}

" File Types {{{
autocmd FileType python source ~/.vim/snippets/python.vim
autocmd FileType html,javascript,typescript source ~/.vim/snippets/html.vim
autocmd FileType html,javascript,typescript,css source ~/.vim/snippets/css.vim
autocmd FileType markdown source ~/.vim/snippets/markdown.vim
autocmd FileType plaintex,context,tex source ~/.vim/snippets/latex.vim
autocmd FileType javascript,typescript source ~/.vim/snippets/javascript.vim
autocmd FileType typescript source ~/.vim/snippets/typescript.vim
autocmd FileType vim source ~/.vim/snippets/vim.vim
" }}}

" Movement {{{
inoremap ;dd :call DeleteMarkerRow(1)
inoremap ;dm :call DeleteMarker(1)
nnoremap ;dd :call DeleteMarkerRow(1)
nnoremap ;dm :call DeleteMarker(1)
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
 nmap <leader>l :bnext<CR>
 nmap <leader>h :bprevious<CR>
 nmap <leader>bd :bp <BAR> bd #<CR>
 nmap <leader>bl :ls<CR>
 " }}}

" Dotfiles {{{
:command! Vrc e ~/.vimrc
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
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c
" }}}

" FileType Specific {{{

" Typescript {{{
autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
nnoremap <leader>cp :SyntasticCheck<cr>
" }}}

" Markdown {{{
let vim_markdown_preview_hotkey='<C-p>'
" }}}

" Latex {{{
autocmd Filetype plaintex,context,tex nnoremap <Leader>p <ESC>:call FormatLatexPar(0)<CR>
autocmd Filetype plaintex,context,tex nnoremap <Leader>o <ESC>:LLPStartPreview<CR>
" }}}

" Python {{{
autocmd FileType python :nnoremap <leader>p :call Yapf()<CR>
autocmd FileType python nnoremap <buffer> <F9> :w<cr> :exec "!python" shellescape(@%, 1)<cr>
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
    echo "Deleted: ".path
endfunction
command! Delview call MyDeleteView()
"}}}

" Other Mappings {{{
nnoremap <C-s> <C-a>
nnoremap <leader>rc !!sh<CR>
nnoremap K kJ
nnoremap <Leader>ac :set invcursorline<cr>:set invcursorcolumn<cr>
nnoremap <Leader>d :Ex<CR>
nnoremap <Leader>bf :%!xxd<cr>
nnoremap <Leader>ws :%s/ $//g<cr>:noh
nnoremap <Leader>wl :v/\S/d<cr>:noh
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
au VimResized * exe "normal! \<c-w>="
" }}}
