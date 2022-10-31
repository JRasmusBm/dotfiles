local mappings = require "jrasmusbm.utils.mappings"

require("jrasmusbm.utils").ensure_setup(" vim-hardtime")

vim.api.nvim_create_user_command("VBG", function(options)
  require("jrasmusbm.utils").ensure_setup("vim-be-good")

  
  vim.cmd[[
  VimBeGood
  ]]

  
end, { nargs = "*" })

vim.g.hardtime_default_on = 1
vim.g.hardtime_maxcount = 1
vim.g.hardtime_timeout = 500
vim.g.hardtime_allow_different_key = 1

mappings.nmap("<leader>ht", "<cmd>HardTimeToggle<CR>", { noremap = true })
