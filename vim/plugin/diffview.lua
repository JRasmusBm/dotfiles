vim.api.nvim_create_user_command("DC", "DiffviewClose", { nargs = "*" })

vim.api.nvim_create_user_command("DO", function(options)
  local args = options.fargs

  if #options.fargs <= 0 then
    args = {
      vim.trim(vim.fn.system "git merge-base `git local-main-branch` HEAD"),
    }
  end

  vim.cmd { cmd = "DiffviewOpen", args = args }
end, { nargs = "*" })

vim.api.nvim_create_user_command("DFH", "DiffviewFileHistory", { nargs = "*" })
