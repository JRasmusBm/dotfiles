vim.api.nvim_create_user_command("Emojify", function()
  require("jrasmusbm.emoji").emojify()
end, { nargs = "*" })
