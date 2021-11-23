local M = {}

function M.setup(options)
  local poetry_venv_path = vim.fn.systemlist({"poetry", "env", "info", "-p"})[1]
  local venv_path = vim.fn.getcwd() .. "/.venv"
  local python_path

  if vim.fn.isdirectory(poetry_venv_path) ~= 0 then
    python_path = poetry_venv_path .. "/bin/python"
  elseif vim.fn.isdirectory(venv_path) ~= 0 then
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
