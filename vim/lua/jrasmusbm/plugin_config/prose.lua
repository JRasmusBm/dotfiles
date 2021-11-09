vim.cmd [[
packadd! thesaurus_query.vim

let g:tq_map_keys=0
let g:tq_use_vim_autocomplete=0

inoremap <leader>cs b:ThesaurusQueryReplaceCurrentWord<CR>
nnoremap <leader>cs :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <leader>cs "ky:ThesaurusQueryReplace <C-r>k<CR>
]]
