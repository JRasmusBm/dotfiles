local M = {}

local lua_language_server = vim.fn.stdpath "cache" .. "/../lua-language-server"
local cmd = nil

if vim.loop.os_uname().sysname ~= "Darwin" then
  cmd = {
    lua_language_server .. "/bin/Linux/lua-language-server",
    "-E",
    lua_language_server .. "/main.lua",
  }
end

local function get_lua_runtime()
  local result = {}
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua/"
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end

  result[vim.fn.expand "$VIMRUNTIME/lua"] = true

  return result
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

function M.setup(options)
  local settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }

  require("lspconfig").lua_ls.setup {
    filetypes = require("jrasmusbm.filetypes").lua,
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    settings = settings,
  }
end

return M
