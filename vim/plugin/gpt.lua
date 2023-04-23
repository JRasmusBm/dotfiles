vim.api.nvim_create_user_command("Chat", function(args)
  require("jrasmusbm.utils").ensure_setup "plenary.nvim"
  require("jrasmusbm.utils").ensure_setup "nui.nvim"
  require("jrasmusbm.utils").ensure_setup "CodeGPT.nvim"

  require("jrasmusbm.utils.commands").run("Chat", args)
end, { nargs = "*", range = true })
