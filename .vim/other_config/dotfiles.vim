:command! Vrc e ~/.vimrc
:command! Nrc e ~/.config/nvim/init.vim
:command! Brc e ~/.bashrc
:command! Zrc e ~/.zshrc
:command! Zenv e ~/.zshenv
:command! Arc e ~/.alacritty.yml
:command! Irc e ~/.install_dependencies

nnoremap <Leader>es :Files ~/.vim/snippets/<CR>
nnoremap <Leader>ep :Files ~/.vim/plugin_config/<CR>
nnoremap <Leader>ef :Files ~/.vim/ftplugin/<CR>
nnoremap <Leader>eo :Files ~/.vim/other_config/<CR>
