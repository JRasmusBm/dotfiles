vim.api.nvim_create_user_command("DO", function(options)
  require("jrasmusbm.diffview").ensure_setup()

  vim.cmd { cmd = "DiffviewOpen", args = options.fargs }
end, { nargs = "*" })

vim.api.nvim_create_user_command("DFH", function(options)
  require("jrasmusbm.diffview").ensure_setup()

  vim.cmd { cmd = "DiffviewFileHistory", args = options.fargs }
end, { nargs = "*" })
