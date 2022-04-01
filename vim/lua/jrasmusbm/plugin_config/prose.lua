local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd! thesaurus_query.vim
]]

vim.g.tq_map_keys = 0
vim.g.tq_use_vim_autocomplete = 0

mappings.imap(
  "<leader>cs",
  "b:ThesaurusQueryReplaceCurrentWord<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>cs",
  ":ThesaurusQueryReplaceCurrentWord<CR>",
  { noremap = true }
)
mappings.vmap(
  "<leader>cs",
  '"ky:ThesaurusQueryReplace <C-r>k<CR>',
  { noremap = true }
)
