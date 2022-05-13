local local_config = vim.fn.getcwd() .. "/.vim/init.lua"
if vim.loop.fs_stat(local_config) then
  vim.cmd("source " .. local_config)
end
