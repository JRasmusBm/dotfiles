packadd! vim-tmux-navigator
packadd! vim-tmux-runner

nmap <localleader>tc :VtrSendCommandToRunner<Space>
nmap <localleader>ta :VtrAttach<Space>
nmap <localleader>to :VtrOpenRunner
nmap <localleader>tk :VtrKillRunner
nmap <localleader>tf :VtrSendFile
nmap <localleader>tl :VtrSendLinesToRunner
nmap <localleader>tp :VtrSendCommandToRunner r
vmap <localleader>tl :'<,'>VtrSendLinesToRunner

let g:VtrStripLeadingWhitespace = 0
