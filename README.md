# Dotfiles

> Author: JRasmusBm

Welcome to the configuration of my system! 😄 

I have been configuring my system since I switched to Linux in the summer 2016.
Sometime around Christmas 2017 I started adding it to source control. The
purpose of this repository is to version control development setup, though I am
very happy to share any learnings along the way. 

**DISCLAIMER**: I change this repository heavily on a nearly daily basis, it is
the very opposite of stable.

# Vim

## Folder Structure

The vim configuration is split up into four folders

- [Filetype Specific Settings](https://github.com/JRasmusBm/dotfiles/tree/master/.vim/ftplugin)
- [Plugin Settings](https://github.com/JRasmusBm/dotfiles/tree/master/.vim/plugin_config)
- [Other Settings](https://github.com/JRasmusBm/dotfiles/tree/master/.vim/other_config)
- [Snippets](https://github.com/JRasmusBm/dotfiles/tree/master/.vim/snippets)

To go to any of these folders, I have `ack.vim` wired up so that

- `<leader>ef` runs `:Files` on the filetype settings directory
- `<leader>ep` runs `:Files` on the plugin settings directory
- `<leader>eo` runs `:Files` on the other settings directory
- `<leader>es` runs `:Files` on the snippets directory

# Install Dependencies

I have a file,
[.install_dependencies](https://github.com/JRasmusBm/dotfiles/tree/master/.install_dependencies),
that contains all the installations I ever perform from the command line on my
system, with specific functions for installing my desktop at its current state
as well as installing my most normal settings on a remote server.

# Inspiration

- [Luke Smith's Dotfiles](https://github.com/LukeSmithxyz/voidrice)
- [Chris Toomey's Dotfiles](https://github.com/christoomey/dotfiles)
- [Greg Hurrel's Dotfiles](https://github.com/wincent/wincent)
- [TJ DeVries](https://github.com/tjdevries)
- [ThePrimeagen](https://github.com/ThePrimeagen)
