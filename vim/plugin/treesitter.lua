require("jrasmusbm.treesitter").ensure_setup()

vim.api.nvim_create_user_command("TSP", function()
  require("jrasmusbm.treesitter.playground").ensure_setup()

 vim.cmd ("TSPlaygroundToggle")

  
end, { nargs = 0})
