return {
  "mfussenegger/nvim-dap-python",
  lazy = true,
  ft = { "python" },
  config = function()
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
  end,
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}
