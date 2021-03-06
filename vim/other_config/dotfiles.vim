:command! Vrc e ~/.vimrc
:command! Nrc e ~/.config/nvim/init.vim
:command! Brc e ~/.bashrc
:command! Zrc e ~/.zshrc
:command! Zenv e ~/.zshenv
:command! Arc e ~/.config/alacritty/alacritty.yml
:command! Irc e ~/.install_dependencies
:command! Grc e ~/.gitconfig
:command! Trc e ~/.tmux.conf
:command! Vsc e ~/.config/nvim/coc-settings.json
:command! Erc e ~/.config/efm-langserver/config.yaml
:command! Frc exec "e $DOTFILES/vim/ftplugin/" . &ft . ".vim"
