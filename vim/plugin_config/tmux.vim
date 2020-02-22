nmap <localleader>tc :VtrSendCommandToRunner<Space>
nmap <localleader>to :VtrOpenRunner
nmap <localleader>tk :VtrKillRunner
nmap <localleader>tf :VtrFocusRunner
nmap <localleader>tl :VtrSendLinesToRunner
vmap <localleader>tl :'<,'>VtrSendLinesToRunner

let g:VtrStripLeadingWhitespace = 0
