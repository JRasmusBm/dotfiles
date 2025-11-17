local M = {}


local state = {

}

function M.on_attach(client, bufnr)
  bufnr = bufnr or 0

  vim.api.nvim_set_option_value(
    "omnifunc",
    "v:lua.vim.lsp.omnifunc",
    { buf = bufnr }
  )

  -- Mappings.
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set({ "n" }, "<leader>aq", function()
    vim.diagnostic.setloclist { open = true }
  end, opts)

  if client:supports_method "textDocument/declaration" then
    vim.keymap.set({ "n" }, "gD", vim.lsp.buf.declaration)
  end

  if client:supports_method "textDocument/definition" then
    vim.keymap.set({ "n" }, "<c-]>", vim.lsp.buf.definition)
  end

  if client:supports_method "textDocument/hover" then
    vim.keymap.set({ "n" }, "K", vim.lsp.buf.hover)
  end

  if client:supports_method "textDocument/implementation" then
    vim.keymap.set({ "n" }, "gi", vim.lsp.buf.implementation)
  end

  if client:supports_method "textDocument/signatureHelp" then
    vim.keymap.set({ "n" }, "gK", vim.lsp.buf.signature_help)
  end

  if client:supports_method "textDocument/typeDefinition" then
    vim.keymap.set({ "n" }, "gt", vim.lsp.buf.type_definition)
  end

  if client:supports_method "textDocument/rename" then
    vim.keymap.set({ "n" }, "g/", vim.lsp.buf.rename)
  end

  if client:supports_method "textDocument/references" then
    vim.keymap.set({ "n" }, "gr", require("telescope.builtin").lsp_references)
  end

  if client:supports_method "textDocument/codeAction" then
    vim.keymap.set({ "n", "v" }, "<leader>af", vim.lsp.buf.code_action)
  end

  if client:supports_method "workspace/symbol" then
    vim.keymap.set(
      { "n" },
      "<leader>as",
      require("telescope.builtin").lsp_workspace_symbols
    )

    vim.keymap.set(
      { "n" },
      "<leader>ad",
      require("telescope.builtin").lsp_dynamic_workspace_symbols
    )
  end

  if client:supports_method "textDocument/document_formatting" then
    vim.keymap.set({ "n" }, "==", function()
      vim.lsp.buf.format { async = true }
    end)
  end

  if client.server_capabilities.inlayHintProvider and vim.bo[bufnr].buftype ~= "" then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  else
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end


  if client:supports_method "textDocument/document_range_formatting" then
    vim.keymap.set({ "v" }, "==", vim.lsp.buf.format)
  end

  if state.original_inlay_hint_handler == nil then
    state.original_inlay_hint_handler = vim.lsp.handlers["textDocument/inlayHint"]
  end


  vim.lsp.handlers["textDocument/inlayHint"] = function(err, result, ctx, config)
    if err and err.message and err.message:find("File not opened in the editor") then
      return
    end
    state.original_inlay_hint_handler(err, result, ctx, config)
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { severity_sort = true }
  )

  -- Set autocommands conditional on server_capabilities
  if client:supports_method "textDocument/documentHighlight" then
    local lsp_document_highlight_augroup =
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = lsp_document_highlight_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      group = lsp_document_highlight_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

return M
