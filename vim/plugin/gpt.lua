vim.api.nvim_create_user_command("Chat", function(args)
  require("jrasmusbm.gpt").ensure_setup()

  require("jrasmusbm.utils.commands").run("Chat", args)
end, { nargs = "*", range = true })
