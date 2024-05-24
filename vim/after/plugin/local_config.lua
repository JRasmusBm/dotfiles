local local_lua_config = vim.fn.getcwd() .. "/.jrb/init.lua"

if vim.loop.fs_stat(local_lua_config) then
  vim.cmd("source " .. local_lua_config)
end
