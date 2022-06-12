local M = {}

local filetypes = {}

for _, ft in ipairs(require("jrasmusbm.filetypes").javascript) do
  filetypes[ft] = true
end

for _, ft in ipairs(require("jrasmusbm.filetypes").typescript) do
  filetypes[ft] = true
end

M.configuration_factory = function(options)
  local result = {
    type = "node2",
    request = "attach",
    restart = true,
    address = "localhost",
    port = options.port,
    localRoot = "${workspaceFolder}",
    remoteRoot = "/home",
    protocol = "inspector",
    skipFiles = {
      "<node_internals>/**",
      "${workspaceFolder}/node_modules/**/*.js",
    },
  }

  for key, value in pairs(options) do
    result[key] = value
  end

  return result
end

local dap = require "dap"

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {
    os.getenv "HOME" .. "/.programs/vscode-node-debug2/out/src/nodeDebug.js",
  },
}

M.default_configurations = {
  M.configuration_factory { name = "Connect to 9000", port = 9000 },
}

return M
