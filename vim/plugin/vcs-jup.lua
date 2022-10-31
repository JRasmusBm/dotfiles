vim.keymap.set({ "n" }, "<localleader>fd", function()
  require("jrasmusbm.utils").ensure_setup "vcs-jump"
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump diff "
end, {})

vim.keymap.set({ "n" }, "<localleader>fg", function()
  require("jrasmusbm.utils").ensure_setup "vcs-jump"
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump grep "
end, {})

vim.keymap.set({ "n" }, "<localleader>fm", function()
  require("jrasmusbm.utils").ensure_setup "vcs-jump"
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump merge "
end, {})
