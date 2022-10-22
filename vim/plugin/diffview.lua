vim.api.nvim_create_user_command("DO", function(_, fargs)
  require("jrasmusbm.diffview").ensure_setup()

  vim.cmd { cmd = "DiffviewOpen", args = fargs }
end, { nargs = "*" })

vim.api.nvim_create_user_command("DFH", function(_, fargs)
  require("jrasmusbm.diffview").ensure_setup()

  vim.cmd { cmd = "DiffviewFileHistory", args = fargs }
end, { nargs = "*" })
