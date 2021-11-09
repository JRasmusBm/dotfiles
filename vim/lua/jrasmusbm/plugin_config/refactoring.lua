vim.cmd [[
packadd! refactoring.nvim

vnoremap <silent> <leader>rf :lua require("jrasmusbm.telescope.refactoring").refactors()
]]
