local M = {}

function M.format()
  local contents = vim.fn.join(vim.fn.getline(1, '$'), "\n")
  print(contents)
end

function M.setup(options)
  require'lspconfig'.pyright.setup{
    on_attach=function (client, bufnr)
      options.on_attach(client)

      if client.resolved_capabilities.document_formatting then
        vim.api.nvim_buf_set_keymap(bufnr,
          "n",
          "==",
          "<cmd>lua require(\"jrasmusbm.lsp.python\").format()<CR>",
          { noremap=true, silent=true }
          )
      end
    end,
  }
end

return M
