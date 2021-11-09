vim.cmd [[
packadd! vim-bushels

inoremap <leader><leader> <++>

imap <leader>dd <Plug>BushelsDeleteMarkerRow
nmap <leader>dd <Plug>BushelsDeleteMarkerRow

imap <leader>dm <Plug>BushelsDeleteMarker
nmap <leader>dm <Plug>BushelsDeleteMarker

imap <leader>da <Plug>BushelsDeleteAllMarkers
nmap <leader>da <Plug>BushelsDeleteAllMarkers

imap <leader>G <Plug>BushelsBackwardMarker
nmap <leader>G <Plug>BushelsBackwardMarker

imap <leader>g <Plug>BushelsForwardMarker
nmap <leader>g <Plug>BushelsForwardMarker

inoremap <leader>cp :call bushels#forward_marker(1)<Enter><C-R>.<Esc>:call bushels#forward_marker(1)
]]
