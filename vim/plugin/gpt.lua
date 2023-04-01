vim.api.nvim_create_user_command("Chat", function(args)
  require("jrasmusbm.utils").ensure_setup "plenary.nvim"
  require("jrasmusbm.utils").ensure_setup "nui.nvim"
  require("jrasmusbm.utils").ensure_setup "CodeGPT.nvim"

  local new_args = {}

  new_args.cmd = "Chat"
  new_args.args = args.fargs

  if args.range ~= 0 then
    new_args.range = { args.line1, args.line2 }
  end

  new_args.bang = args.bang

  vim.cmd(new_args)
end, { nargs = "*", range = true })
