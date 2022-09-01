vim.cmd [[
:command! Vrc exec "e $DOTFILES/vim/vimrc"
:command! Nrc exec "e $DOTFILES/vim/init.vim"
:command! Lrc exec "e $DOTFILES/vim/lua/jrasmusbm/init.lua"
:command! Brc exec "e $DOTFILES/shell/bashrc"
:command! Zrc exec "e $DOTFILES/shell/zshrc"
:command! Zenv exec "e $DOTFILES/shell/zshenv"
:command! Arc exec "e $DOTFILES/terminal/alacritty.yml"
:command! Grc exec "e $DOTFILES/git/gitconfig"
:command! Trc exec "e $DOTFILES/tmux/tmux.conf"
:command! Frc exec "e $DOTFILES/vim/ftplugin/" . &ft . ".lua"
:command! Prc e ./.vim/init.lua
]]
