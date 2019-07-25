Plug 'Ron89/thesaurus_query.vim'

let g:tq_map_keys=0

nnoremap <unique><silent> <Leader>cs :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <unique><silent> <Leader>cs "ky:ThesaurusQueryReplace <C-r>k<CR>
nnoremap <silent> <LocalLeader>cs :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <silent> <LocalLeader>cs "ky:ThesaurusQueryReplace <C-r>k<CR>
