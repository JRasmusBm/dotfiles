require("jrasmusbm.utils").ensure_setup "vim-tmux-navigator"

vim.cmd [[
packadd vim-tmux-navigator
]]

vim.g.vtr_filetype_runner_overrides = {
  rust = "cargo run {file}",
  go = "go run {file}",
}

vim.g.VtrStripLeadingWhitespace = 0

vim.keymap.set({ "n" }, "<localleader>td", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  vim.cmd "VtrSendCtrlD"
end)

vim.keymap.set({ "n" }, "<localleader>tc", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  vim.cmd "VtrSendCtrlC"
end)

vim.keymap.set({ "n" }, "<localleader>tr", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  require("jrasmusbm.utils.mappings").feedkeys ":VtrSendCommandToRunner<Space>"
end)

vim.keymap.set({ "n" }, "<localleader>ta", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  require("jrasmusbm.utils.mappings").feedkeys ":VtrAttach<Space>"
end)

vim.keymap.set({ "n" }, "<localleader>to", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  vim.cmd "VtrOpenRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tk", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  vim.cmd "VtrKillRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tf", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  vim.cmd "VtrSendFile"
end)

vim.keymap.set({ "n" }, "<localleader>tl", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  vim.cmd "VtrSendLinesToRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tp", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  vim.cmd "VtrSendCommandToRunner r"
end)

vim.keymap.set({ "v" }, "<localleader>tl", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"

  vim.cmd [[
  '<,'>VtrSendLinesToRunner
  ]]
end, {})
