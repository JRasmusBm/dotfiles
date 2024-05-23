vim.api.nvim_create_user_command("VDep", function(args)
  local file_name = vim.split(args.fargs[1], "/")[2] .. ".lua"
  vim.cmd("e " .. os.getenv "DOTFILES" .. "/vim/lua/plugins/" .. file_name)
end, { nargs = 1 })
