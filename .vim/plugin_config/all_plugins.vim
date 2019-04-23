if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'mhartington/nvim-typescript', {'do': 'npm install && npm run build'}
else
  Plug 'leafgarland/typescript-vim'
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Olical/vim-enmasse'
Plug 'Quramy/tsuquyomi'
Plug 'Ron89/thesaurus_query.vim'
Plug 'Shougo/vimproc.vim'
Plug 'VundleVim/Vundle.vim'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-sort-motion'
Plug 'eagletmt/ghcmod-vim'
Plug 'easymotion/vim-easymotion'
Plug 'elzr/vim-json'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'google/vim-maktaba'
Plug 'gregsexton/gitv'
Plug 'hail2u/vim-css3-syntax'
Plug 'heavenshell/vim-tslint-config'
Plug 'ianks/vim-tsx'
Plug 'ivanov/vim-ipython'
Plug 'jceb/vim-orgmode'
Plug 'jceb/vim-textobj-uri'
Plug 'jiangmiao/auto-pairs'
Plug 'jparise/vim-graphql'
Plug 'jrasmusbm/Latex-Text-Formatter'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'lucapette/vim-textobj-underscore'
Plug 'mileszs/ack.vim'
Plug 'nvie/vim-flake8'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/vim-wasm'
Plug 'sickill/vim-pasta'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'thinca/vim-textobj-between'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/indentpython.vim'
Plug 'zhimsel/vim-stay'
call glaive#Install()
