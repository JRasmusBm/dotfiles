local M = {}

function M.on_attach(client, bufnr)
  bufnr = bufnr or 0
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("illuminate").on_attach(client)

  -- Mappings.
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set({ "n" }, "g?", vim.diagnostic.open_float, opts)

  vim.keymap.set({ "n" }, "[v", function()
    vim.diagnostic.goto_prev {
      severity = { min = vim.diagnostic.severity.ERROR },
    }
  end, opts)

  vim.keymap.set({ "n" }, "]v", function()
    vim.diagnostic.goto_next {
      severity = { min = vim.diagnostic.severity.ERROR },
    }
  end, opts)

  vim.keymap.set({ "n" }, "[V", function()
    vim.diagnostic.goto_prev {
      severity = { max = vim.diagnostic.severity.WARN },
    }
  end, opts)

  vim.keymap.set({ "n" }, "]V", function()
    vim.diagnostic.goto_next {
      severity = { max = vim.diagnostic.severity.WARN },
    }
  end, opts)

  vim.keymap.set({ "n" }, "<localleader>q", function()
    vim.diagnostic.setloclist { open = true }
  end, opts)

  if client.supports_method "textDocument/declaration" then
    vim.keymap.set({ "n" }, "gD", vim.lsp.buf.declaration)
  end

  if client.supports_method "textDocument/definition" then
    vim.keymap.set({ "n" }, "<c-]>", vim.lsp.buf.definition)
  end

  if client.supports_method "textDocument/hover" then
    vim.keymap.set({ "n" }, "K", vim.lsp.buf.hover)
  end

  if client.supports_method "textDocument/implementation" then
    vim.keymap.set({ "n" }, "gi", vim.lsp.buf.implementation)
  end

  if client.supports_method "textDocument/signatureHelp" then
    vim.keymap.set({ "n" }, "gK", vim.lsp.buf.signature_help)
  end

  if client.supports_method "textDocument/typeDefinition" then
    vim.keymap.set({ "n" }, "gt", vim.lsp.buf.type_definition)
  end

  if client.supports_method "textDocument/rename" then
    vim.keymap.set({ "n" }, "g/", vim.lsp.buf.rename)
  end

  if client.supports_method "textDocument/references" then
    vim.keymap.set({ "n" }, "gr", require("telescope.builtin").lsp_references)
  end

  if client.supports_method "textDocument/codeAction" then
    vim.keymap.set(
      { "n" },
      ";af",
      require("telescope.builtin").lsp_code_actions
    )

    vim.keymap.set(
      { "v" },
      ";af",
      require("telescope.builtin").lsp_range_code_actions
    )
  end

  if client.supports_method "workspace/symbol" then
    vim.keymap.set(
      { "n" },
      ";as",
      require("telescope.builtin").lsp_workspace_symbols
    )

    vim.keymap.set(
      { "n" },
      ";ad",
      require("telescope.builtin").lsp_dynamic_workspace_symbols
    )
  end

  if client.supports_method "textDocument/document_formatting" then
    vim.keymap.set({ "n" }, "==", function()
      vim.lsp.buf.format { async = true }
    end)
  end

  if client.supports_method "textDocument/document_range_formatting" then
    vim.keymap.set({ "v" }, "==", vim.lsp.buf.range_formatting)
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { severity_sort = true }
  )

  -- Set autocommands conditional on server_capabilities
  if client.supports_method "textDocument/documentHighlight" then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

return M
