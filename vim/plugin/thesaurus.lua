vim.g.tq_map_keys = 0
vim.g.tq_use_vim_autocomplete = 0

vim.keymap.set({ "i" }, "<leader>cs", function()
  require("jrasmusbm.utils").ensure_setup "thesaurus_query.vim"
  require("jrasmusbm.utils.mappings").feedkeys "<Esc>h:ThesaurusQueryReplaceCurrentWord<CR>"
end, { noremap = true })
vim.keymap.set({ "n" }, "<leader>cs", function()
  require("jrasmusbm.utils").ensure_setup "thesaurus_query.vim"
  require("jrasmusbm.utils.mappings").feedkeys "<Esc>:ThesaurusQueryReplaceCurrentWord<CR>"

  vim.cmd [[
    ThesaurusQueryReplaceCurrentWord
    ]]
end, { noremap = true })

vim.keymap.set({ "v" }, "<leader>cs", function()
  require("jrasmusbm.utils").ensure_setup "thesaurus_query.vim"
  require("jrasmusbm.utils.mappings").feedkeys '"ky:ThesaurusQueryReplace <C-r>k<CR>'
end, { noremap = true })
