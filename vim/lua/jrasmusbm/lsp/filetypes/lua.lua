local M = {}

local lua_language_server = vim.fn.stdpath("cache") .. "/../lua-language-server"

local function get_lua_runtime()
  local result = {};
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua/";
    if vim.fn.isdirectory(lua_path) then result[lua_path] = true end
  end

  result[vim.fn.expand("$VIMRUNTIME/lua")] = true

  return result;
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

function M.setup(options)
  require("lspconfig").sumneko_lua.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    filetypes = require("jrasmusbm.filetypes").lua,
    cmd = {
      lua_language_server .. "/bin/Linux/lua-language-server",
      "-E",
      lua_language_server .. "/main.lua",
    },
    settings = {
      Lua = {
        runtime = {version = "LuaJIT", path = runtime_path},
        diagnostics = {globals = {"vim"}},
        workspace = {
          library = get_lua_runtime(),
          maxPreload = 10000,
          preloadFileSize = 10000,
        },
        telemetry = {enable = false},
      },
    },
  }
end

return M
