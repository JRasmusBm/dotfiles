local M = {}

local lua_language_server = vim.fn.stdpath("cache").."/../lua-language-server"

function M.setup(options)
  require("lspconfig").sumneko_lua.setup{ on_attach=options.on_attach , cmd = {lua_language_server.."/bin/Linux/lua-language-server", "-E", lua_language_server.."/main.lua"};
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        telemetry = {
          enable = false,
        },
      },
  },}
end

return M
