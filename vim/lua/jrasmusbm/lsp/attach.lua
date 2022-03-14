local M = {}

function M.on_attach(client, bufnr)
  bufnr = bufnr or 0
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("illuminate").on_attach(client)

  -- Mappings.
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set({ "n" }, "g?", vim.diagnostic.open_float, opts)

  vim.keymap.set({ "n" }, "[v", function()
    vim.diagnostic.goto_prev { severity = { min = vim.diagnostic.severity.ERROR } }
  end, opts)
  vim.keymap.set({ "n" }, "]v", function()
    vim.diagnostic.goto_next { severity = { min = vim.diagnostic.severity.ERROR } }
  end, opts)
  vim.keymap.set({ "n" }, "[V", function()
    vim.diagnostic.goto_prev { severity = { max = vim.diagnostic.severity.WARN } }
  end, opts)
  vim.keymap.set({ "n" }, "]V", function()
    vim.diagnostic.goto_next { severity = { max = vim.diagnostic.severity.WARN } }
  end, opts)

  vim.keymap.set({ "n" }, "<localleader>q", function()
    vim.diagnostic.setloclist { open = true }
  end, opts)

  for _, capability in ipairs(require "jrasmusbm.lsp.capabilities") do
    if client.resolved_capabilities[capability.name] then
      vim.keymap.set(capability.modes or { "n" }, capability.mapping, capability.handler, opts)
    end
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { severity_sort = true }
  )

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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
