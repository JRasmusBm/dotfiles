vim.cmd [[
packadd! vim-presentation-mode

nnoremap <leader>vc :VpmOff<cr>
nnoremap <leader>vn :VpmNextHighlight<cr>
nnoremap <leader>vp :VpmPreviousHighlight<cr>
nnoremap <leader>vf :VpmOpenNextFile<cr>

let g:vpm_highlight_color='gray'
]]
