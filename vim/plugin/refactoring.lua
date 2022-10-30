vim.keymap.set({ "v" },
  "<leader>rf",
  ":lua require('jrasmusbm.telescope.refactoring').refactors()<CR>",
  { noremap = true, silent = true }
)
