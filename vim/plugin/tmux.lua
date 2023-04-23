require("jrasmusbm.utils").ensure_setup "vim-tmux-navigator"

vim.keymap.set({ "n" }, "<localleader>td", function()
  require("jrasmusbm.tmux").ensure_setup()
  vim.cmd "VtrSendCtrlD"
end)

vim.keymap.set({ "n" }, "<localleader>tc", function()
  require("jrasmusbm.tmux").ensure_setup()
  vim.cmd "VtrSendCtrlC"
end)

vim.keymap.set({ "n" }, "<localleader>tr", function()
  require("jrasmusbm.tmux").ensure_setup()
  require("jrasmusbm.utils.mappings").feedkeys ":VtrSendCommandToRunner<Space>"
end)

vim.keymap.set({ "n" }, "<localleader>ta", function()
  require("jrasmusbm.tmux").ensure_setup()
  require("jrasmusbm.utils.mappings").feedkeys ":VtrAttach<Space>"
end)

vim.keymap.set({ "n" }, "<localleader>to", function()
  require("jrasmusbm.tmux").ensure_setup()
  vim.cmd "VtrOpenRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tk", function()
  require("jrasmusbm.tmux").ensure_setup()
  vim.cmd "VtrKillRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tf", function()
  require("jrasmusbm.tmux").ensure_setup()
  vim.cmd "VtrOpenRunner"
  vim.cmd "VtrSendFile"
end)

vim.keymap.set({ "n" }, "<localleader>tl", function()
  require("jrasmusbm.tmux").ensure_setup()
  vim.cmd "VtrOpenRunner"
  vim.cmd "VtrSendLinesToRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tp", function()
  require("jrasmusbm.tmux").ensure_setup()
  vim.cmd "VtrOpenRunner"
  vim.cmd "VtrSendCommandToRunner r"
end)

vim.keymap.set({ "v" }, "<localleader>tl", function()
  require("jrasmusbm.tmux").ensure_setup()

  require("jrasmusbm.utils.visual").run_with_range "VtrSendLinesToRunner"
end)
