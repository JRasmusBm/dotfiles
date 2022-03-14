local M = {}

local dap = require "dap"

dap.adapters.python = {
  type = "executable",
  command = ".venv/bin/python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      local cwd = vim.fn.getcwd()

      if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      end

      return "/usr/bin/python"
    end,
  },
  {
    type = "python",
    request = "custom",
    name = "Attach to debugger",
    command = "Debugpy attach 0.0.0.0 5678",
  },
}

M.debug_test = function(cmd)
  local temp_unittest = vim.g["test#python#pyunit#executable"]
  local temp_pytest = vim.g["test#python#pytest#executable"]

  vim.g["test#python#pytest#executable"] = "python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m pytest"
  vim.g["test#python#pyunit#executable"] = "python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m unittest"

  vim.cmd(cmd)

  vim.g["test#python#pytest#executable"] = temp_pytest
  vim.g["test#python#pyunit#executable"] = temp_unittest

  vim.defer_fn(
    vim.schedule_wrap(function()
      vim.cmd [[
  Debugpy attach 0.0.0.0 5678
  ]]
    end),
    1000
  )
end

return M
