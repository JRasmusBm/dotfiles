let g:tq_map_keys=0

inoremap <leader>cs b:ThesaurusQueryReplaceCurrentWord<CR>
nnoremap <unique><silent> <Leader>cs :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <unique><silent> <Leader>cs "ky:ThesaurusQueryReplace <C-r>k<CR>
