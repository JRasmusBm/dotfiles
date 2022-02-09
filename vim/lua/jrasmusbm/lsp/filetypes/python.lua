local M = {}

function M.setup(options)
  local venv_path = vim.fn.getcwd() .. "/.venv"
  local python_path

  if vim.fn.isdirectory(venv_path) ~= 0 then
    python_path = venv_path .. "/bin/python"
  else
    python_path = "python"
  end

  require"lspconfig".pyright.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    filetypes = require("jrasmusbm.filetypes").python,
    settings = {python = {pythonPath = python_path}},
  }
end

return M
