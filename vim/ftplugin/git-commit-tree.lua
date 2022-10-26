local git_commit_tree_augroup = vim.api.nvim_create_augroup(
  "git_commit_tree",
  { clear = true }
)
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = git_commit_tree_augroup,
  pattern = { "temp_git_tree" },
  callback = function()
    vim.fn["jrasmusbm#git#list_tree"]()
  end,
})

local switch_to_git_status = function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd [[ Git ]]
  vim.api.nvim_buf_delete(buf, { unload = true })
end

vim.api.nvim_buf_create_user_command(0, "G", function(options)
  require("jrasmusbm.utils").ensure_setup "vim-rhubarb"
  require("jrasmusbm.utils").ensure_setup "fugitive-gitlab.vim"
  require("jrasmusbm.utils").ensure_setup "vim-fugitive"

  if #options.fargs == 0 then
    switch_to_git_status()
    return
  end

  vim.cmd("Git " .. options.args)
  vim.fn["jrasmusbm#git#list_tree"]()
end, { nargs = "*" })

vim.keymap.set({ "n" }, "H", function()
  require("jrasmusbm.utils").ensure_setup "vim-rhubarb"
  require("jrasmusbm.utils").ensure_setup "fugitive-gitlab.vim"
  require("jrasmusbm.utils").ensure_setup "vim-fugitive"
  switch_to_git_status()
end, { buffer = true })
vim.keymap.set({ "n" }, "L", function()
  vim.fn["jrasmusbm#git#list_tree"]()
end, { buffer = true })
