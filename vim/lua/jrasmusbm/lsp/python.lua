local M = {}

function M.format()
  local contents = vim.fn.join(vim.fn.getline(1, '$'), "\n")
  local pyproject_path = vim.fn.getcwd() .. "/pyproject.toml"
  local command = { "black", "-c", contents }
  if vim.fn.filereadable(pyproject_path) ~= 0 then
    command = { "black", "--config", pyproject_path , "-c", contents }
  end
  local formatted = vim.fn.systemlist(command)
  vim.fn.deletebufline("%", 1, "$")
  vim.fn.setline(1, formatted)
end

function M.setup(options)
  local poetry_venv_path =vim.fn.systemlist({ "poetry", "env" ,"info","-p" })[1] .. "/bin/python"
  local python_path = "python"

  if vim.fn.filereadable(poetry_venv_path) then
    python_path = poetry_venv_path
  end

  require'lspconfig'.pyright.setup{
    on_attach=function (client, bufnr)
      options.on_attach(client)

      vim.api.nvim_buf_set_keymap(bufnr,
        "n",
        "==",
        "<cmd>lua require(\"jrasmusbm.lsp.python\").format()<CR>",
        { noremap=true, silent=true }
        )
    end,
    settings={
      python = {
        pythonPath=python_path
      }
    }
  }
end

return M
