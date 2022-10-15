# Dotfiles

> Author: JRasmusBm

Welcome to the configuration of my system! 😄

I have been configuring my system since I switched to Linux in the summer 2016.
Sometime around Christmas 2017 I started adding it to source control. The
purpose of this repository is to version control development setup, though I am
very happy to share any learnings along the way.

**DISCLAIMER**: I change this repository heavily on a nearly daily basis, it is
the very opposite of stable.

## Table of Contents

- [Inspiration](#inspiration)
- [Installation](#installation)
  - [Software](#software)
  - [Symlinks](#symlinks)
- [Folder Structure](#folder-structure)

## Inspiration

- [Greg Hurrel's Dotfiles](https://github.com/wincent/wincent)
- [TJ DeVries](https://github.com/tjdevries)
- [ThePrimeagen](https://github.com/ThePrimeagen)
- [Chris Toomey's Dotfiles](https://github.com/christoomey/dotfiles)
- [Luke Smith's Dotfiles](https://github.com/LukeSmithxyz/voidrice)

## Installation

### Software

I have luckily not had to set up my whole development environment from scratch
very often. I do however find myself needing to install one tool or another on
my system or on a remote machine. Hence I have collected a number of install
scripts for some of the software I use in
[install_dependencies](./install_dependencies).

I have then made the utility `idep <program>` which runs any one of those
install scripts, if it exists. If I were to install my system from scratch more
often I would create collection scripts in
[install_dependencies](./install_dependencies) with the collections of programs
I consider a bare minimum on a new system.

### Symlinks

In order to install my dotfiles, one would first install Python and the
dependencies listed in [requirements-dev.txt](./scripts/requirements-dev.txt).
One would then run `sh scripts/symlink` from the root of the project.
This will attempt to symlink the files into their correct locations, copying all
the files replaced into a ~/.backup_dotfiles folder.

## Folder Structure

The vim configuration is split up into multiple files and folders. The main
priority here has been configurability, meaning that I want there to be as
little time as possible from the moment that I want to change something until
I have made the change. I usually move around my configuration
using the mappings found in
[vim/other_config/dotfiles.vim](./vim/other_config/dotfiles.vim) and
[vim/plugin_config/search.vim](vim/plugin_config/search.vim).

For people that want to click their way through the file tree, here follows
a non-comprehensive list of where you can find things:

- [bin](./bin) - My large collection of executable scripts. The more I learn about the Unix
  philosophy I realize that having a large collection of scripts that
  integrate well is very useful.
  - Note that any script prefixed `git-` (i.e. `git-first`) can be used as
    a git command (i.e. `git first`). I find this superior to aliases cause it
    leaves room for adding extra code and configuration for each command.
- [files.csv](./files.csv) - The list of files linked by [scripts/symlink](./scripts/symlink)
- [git](./git) - Git-related configuration (as noted above I use scripts instead of
  aliases, and those can be found in the [bin](./bin) folder)
- [install_dependencies](./install_dependencies) - Scripts that can be used with `idep <script>` to
  install things onto my system.
- [lsp](./lsp) - LSP-configuration that does not feel editor-specific
- [scripts](./scripts) - Installation scripts, will probably be phased out in favor of
  [install_dependencies](./vim/install_dependencies)
- [shell](./shell) - Shell configuration. I try to use scripts instead of aliases
  whenever possible.
- [terminal](./terminal) - Terminal configuration
- [tmux](./tmux) - Tmux configuration
- [vim](./vim)
  - Vim configuration according to the default folder structure other_config
  - [plugin_config](./vim/plugin_config) - Any configuration related to plugins that are still
    sourced in vimscript.
  - [queries](./vim/queries) - Treesitter queries
  - [snippets](./vim/lua/jrasmusbm/snippets/shared) - My snippets by language
- [window_manager](./window_manager) - WM config (I use i3)
- [witchcraft](./witchcraft) - Browser scripting (used to have these public but they've
  started becoming more private so I moved them to a private repository)
