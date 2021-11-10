local M = {}

local mappings = require("jrasmusbm.utils.mappings")

vim.cmd [[
packadd! spelunker.vim
packadd! popup-menu.nvim
]]

vim.g.spelunker_target_min_char_len = 4
vim.g.spelunker_max_suggest_words = 15
vim.g.spelunker_max_hi_words_each_buf = 100

vim.g.spelunker_check_type = 2 -- Only visible text (not whole file)
vim.g.spelunker_highlight_type = 1 -- All types
vim.g.spelunker_disable_uri_checking = 1
vim.g.spelunker_disable_email_checking = 1
vim.g.spelunker_disable_account_name_checking = 1
vim.g.spelunker_disable_acronym_checking = 1
vim.g.spelunker_disable_backquoted_checking = 1
vim.g.spelunker_disable_auto_group = 1

local remap = function ()
  if vim.o.spell == 0 then
    mappings.nmap("]s", "<Plug>(spelunker-jump-next)", { silent= true })
    mappings.nmap("[s", "<Plug>(spelunker-jump-prev)", { silent= true })
  else
    mappings.nmap("]s", "]s", { noremap =  true })
    mappings.nmap("[s", "[s", { noremap =  true })
  end
end

M.check_file = function ()
  if vim.o.spell == 0 then
    vim.fn["spelunker#check"]()
  end

  remap()
end

M.check_displayed_words  = function ()
  if vim.o.spell == 0 then
    vim.fn["spelunker#check_displayed_words"]()
  end

  remap()
end

vim.cmd [[
augroup spelunker
  autocmd!
  autocmd BufWinEnter,BufWritePost * lua require("jrasmusbm.plugin_config.spell").check_file()
  autocmd CursorHold * lua require("jrasmusbm.plugin_config.spell").check_displayed_words()
augroup END
]]

return M
