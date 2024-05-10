vim.keymap.set({ "n" }, "<localleader>td", function()
  vim.cmd "VtrSendCtrlD"
end)

vim.keymap.set({ "n" }, "<localleader>tc", function()
  vim.cmd "VtrSendCtrlC"
end)

vim.keymap.set({ "n" }, "<localleader>tr", function()
  require("jrasmusbm.utils.mappings").feedkeys ":VtrSendCommandToRunner<Space>"
end)

vim.keymap.set({ "n" }, "<localleader>ta", function()
  require("jrasmusbm.utils.mappings").feedkeys ":VtrAttach<Space>"
end)

vim.keymap.set({ "n" }, "<localleader>to", function()
  vim.cmd "VtrOpenRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tk", function()
  vim.cmd "VtrKillRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tf", function()
  vim.cmd "VtrOpenRunner"
  vim.cmd "VtrSendFile"
end)

vim.keymap.set({ "n" }, "<localleader>tl", function()
  vim.cmd "VtrOpenRunner"
  vim.cmd "VtrSendLinesToRunner"
end)

vim.keymap.set({ "n" }, "<localleader>tp", function()
  vim.cmd "VtrOpenRunner"
  vim.cmd "VtrSendCommandToRunner r"
end)

vim.keymap.set({ "v" }, "<localleader>tl", function()
  require("jrasmusbm.utils.visual").run_with_range "VtrSendLinesToRunner"
end)
