vim.api.nvim_create_user_command("DO", function(options)
  require("jrasmusbm.diffview").ensure_setup()
  local args = options.fargs

  if #options.fargs <= 0 then
    args = {
      vim.trim(vim.fn.system "git merge-base `git local-main-branch` HEAD"),
    }
  end

  vim.cmd { cmd = "DiffviewOpen", args = args }
end, { nargs = "*" })

vim.api.nvim_create_user_command("DFH", function(options)
  require("jrasmusbm.diffview").ensure_setup()

  vim.cmd { cmd = "DiffviewFileHistory", args = options.fargs }
end, { nargs = "*" })
