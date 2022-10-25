local os = require "os"
local io = require "io"

vim.g.python3_host_prog = os.getenv "HOME" .. "/.virtualenvs/neovim3/bin/python"

vim.cmd "syntax on"
vim.cmd "filetype plugin indent on"

vim.g.mapleader = ";"
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap("n", "ö", ";", { noremap = true })

local dotfiles = os.getenv "DOTFILES"
if dotfiles == nil then
  vim.fn.setenv("DOTFILES", os.getenv "HOME" .. "/dotfiles")
end

vim.cmd [[ packadd! plenary.nvim ]]

vim.opt.secure = true

require "jrasmusbm.dap"
require "jrasmusbm.lsp"
require "jrasmusbm.treesitter"
require "jrasmusbm.snippets"
