local mappings = require "jrasmusbm.utils.mappings"

require("jrasmusbm.utils").ensure_setup("vim-tmux-navigator")

vim.cmd [[
packadd vim-tmux-navigator
packadd vim-tmux-runner
]]

vim.g.vtr_filetype_runner_overrides = {
  rust = "cargo run {file}",
  go = "go run {file}",
}

vim.keymap.set({ "n" },"<localleader>tQ",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrSendCtrlD<CR>")
end
)

vim.keymap.set({ "n" },"<localleader>tq",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrSendCtrlC<CR>")
end
)

vim.keymap.set({ "n" },"<localleader>tc",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrSendCommandToRunner<Space>")
end
)

vim.keymap.set({ "n" },"<localleader>ta",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrAttach<Space>")
end
)

vim.keymap.set({ "n" },"<localleader>to",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrOpenRunner<CR>")
end
)

vim.keymap.set({ "n" },"<localleader>tk",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrKillRunner<CR>")
end
)

vim.keymap.set({ "n" },"<localleader>tf",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrSendFile<CR>")
end
)

vim.keymap.set({ "n" },"<localleader>tl",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrSendLinesToRunner<CR>")
end
)

vim.keymap.set({ "n" },"<localleader>tp",function ()
  require("jrasmusbm.utils").ensure_setup("vim-tmux-runner")
  vim.cmd( "VtrSendCommandToRunner r<CR>")
end
)

mappings.vmap("<localleader>tl", ":'<,'>VtrSendLinesToRunner<CR>")
mappings.nmap("<localleader>tr", ":!tmux last-window && tmux last-pane<cr>")

vim.g.VtrStripLeadingWhitespace = 0

vim.defer_fn(function()
  vim.cmd "silent VtrAttachToPane 1"
end, 100)
