local os = require("os")
local io = require("io")

print(vim.inspect({file = "vim/lua/init.lua", line = 5, "hello"}))

vim.g.python3_host_prog = os.getenv("HOME") ..
                            "/.virtualenvs/neovim3/bin/python"

vim.cmd "syntax on"
vim.cmd "filetype plugin indent on"

vim.g.mapleader = ";"
vim.g.maplocalleader = "<Space>"

vim.opt.exrc = true

vim.api.nvim_set_keymap("n", "ö", ";", {noremap = true})

local source_config_files_in = function(module)
  -- Inspired by @ChrisToomey's vimrc.
  local process = io.popen("ls vim/lua/jrasmusbm/" .. module .. "/*")
  local result = vim.split(process:read("a*"), "\n")
  for _, file in ipairs(result) do
    if file ~= "" then
      dofile(file)
    end
  end
  process.close()
end

vim.cmd [[ packadd! plenary.nvim ]]

source_config_files_in("plugin_config")
source_config_files_in("other_config")

vim.opt.secure = true

-- require("jrasmusbm.telescope")
-- require("jrasmusbm.diffview")
-- require("jrasmusbm.harpoon")
-- require("jrasmusbm.treesitter")
-- require("jrasmusbm.lsp")
-- require("jrasmusbm.dap")
