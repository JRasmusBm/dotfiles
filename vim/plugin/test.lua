vim.keymap.set({ "n" }, "<localleader>dn", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  require("jrasmusbm.test").ensure_setup()
  vim.cmd [[ TestNearest ]]
end, { noremap = true })

vim.keymap.set({ "n" }, "<localleader>df", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  require("jrasmusbm.test").ensure_setup()
  vim.cmd [[ TestFile ]]
end, { noremap = true })

vim.keymap.set({ "n" }, "<localleader>ds", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  require("jrasmusbm.test").ensure_setup()
  vim.cmd [[ TestSuite ]]
end, { noremap = true })

vim.keymap.set({ "n" }, "<localleader>dp", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  require("jrasmusbm.test").ensure_setup()
  vim.cmd [[ TestLast ]]
end, { noremap = true })

vim.keymap.set({ "n" }, "<localleader>dv", function()
  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"
  require("jrasmusbm.test").ensure_setup()
  vim.cmd [[ TestVisit ]]
end, { noremap = true })
