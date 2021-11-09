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

local source_config_files_in = vim.schedule_wrap(function(module)
  -- Inspired by @ChrisToomey's vimrc.
  local path = os.getenv("DOTFILES") .. "/vim/lua/jrasmusbm/" .. module
  require("jrasmusbm.utils").for_each_file_in_directory(path,
                                                        function(file_name)
                                                          print(
                                                            vim.inspect({
                                                                file = "vim/lua/jrasmusbm/init.lua",
                                                                line = 27,
                                                                path,
                                                                file_name,
                                                              })
                                                            )
    local full_module = path .. "/" .. file_name
    print(vim.inspect({
      file = "vim/lua/jrasmusbm/init.lua",
      line = 32,
      full_module,
    }))
    dofile(full_module)

  end)
end)

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
