local mappings = require("jrasmusbm.utils.mappings")

vim.cmd [[
packadd! vim-tmux-navigator
packadd! vim-tmux-runner
]]

vim.g.vtr_filetype_runner_overrides = {
      rust= "cargo run {file}",
      go= "go run {file}"
       }

mappings.nmap("<localleader>tc",":VtrSendCommandToRunner<Space>")
mappings.nmap("<localleader>ta",":VtrAttach<Space>")
mappings.nmap("<localleader>to",":VtrOpenRunner<CR>")
mappings.nmap("<localleader>tk",":VtrKillRunner<CR>")
mappings.nmap("<localleader>tf",":VtrSendFile<CR>")
mappings.nmap("<localleader>tl",":VtrSendLinesToRunner<CR>")
mappings.nmap("<localleader>tp",":VtrSendCommandToRunner r<CR>")
mappings.vmap("<localleader>tl",":'<,'>VtrSendLinesToRunner<CR>")
mappings.nmap("<localleader>tr", ":!tmux last-window && tmux last-pane<cr>")

vim.g.VtrStripLeadingWhitespace = 0
