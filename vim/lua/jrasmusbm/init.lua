local os = require "os"

vim.g.python3_host_prog = os.getenv "HOME" .. "/.virtualenvs/neovim3/bin/python"

vim.cmd "syntax on"
vim.cmd "filetype plugin indent on"

vim.g.mapleader = ";"
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup "plugins"

vim.api.nvim_set_keymap("n", "ö", ";", { noremap = true })

local dotfiles = os.getenv "DOTFILES"
if dotfiles == nil then
  vim.fn.setenv("DOTFILES", os.getenv "HOME" .. "/dotfiles")
end

vim.opt.secure = true
