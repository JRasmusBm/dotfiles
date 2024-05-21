local git_commit_tree_augroup =
    vim.api.nvim_create_augroup("git_commit_tree", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = git_commit_tree_augroup,
  pattern = { "temp_git_tree" },
  callback = function()
    require("jrasmusbm.git").list_tree()
  end,
})

local switch_to_git_status = function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd [[ G ]]
  vim.api.nvim_buf_delete(buf, { unload = true })
end

vim.keymap.set({ "n" }, "H", function()
  switch_to_git_status()
end, { buffer = true })

vim.keymap.set({ "n" }, "L", function()
  require("jrasmusbm.git").list_tree()
end, { buffer = true })
