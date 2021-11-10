vim.cmd [[
packadd! vim-tmux-navigator
packadd! vim-tmux-runner

let g:vtr_filetype_runner_overrides = {
      \"rust": "cargo run {file}",
      \"go": "go run {file}"
      \ }

nmap <localleader>tc :VtrSendCommandToRunner<Space>
nmap <localleader>ta :VtrAttach<Space>
nmap <localleader>to <cmd>VtrOpenRunner<CR>
nmap <localleader>tk <cmd>VtrKillRunner<CR>
nmap <localleader>tf <cmd>VtrSendFile<CR>
nmap <localleader>tl <cmd>VtrSendLinesToRunner<CR>
nmap <localleader>tp <cmd>VtrSendCommandToRunner r<CR>
vmap <localleader>tl <cmd>'<,'>VtrSendLinesToRunner<CR>

let g:VtrStripLeadingWhitespace = 0
]]
