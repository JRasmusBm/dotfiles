local M = {};

function M.on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_keymap_if_supported(feature, ...)
    if client.resolved_capabilities[feature] then buf_set_keymap(...) end
  end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  require"illuminate".on_attach(client)

  -- Mappings.
  local opts = {noremap = true, silent = true}

  buf_set_keymap("n", "g?",
    "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[v",
    "<cmd>lua vim.lsp.diagnostic.goto_prev{ severity_limit=\"Error\" }<CR>",
    opts)
  buf_set_keymap("n", "]v",
    "<cmd>lua vim.lsp.diagnostic.goto_next{ severity_limit=\"Error\" }<CR>",
    opts)
  buf_set_keymap("n", "[V", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]V", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q",
    "<cmd>lua vim.diagnostic.setloclist({ open=true })<CR>", opts)
  buf_set_keymap("n", ";ae",
    "<cmd>lua require(\"telescope.builtin\").lsp_workspace_diagnostics()<CR>",
    opts)

  buf_set_keymap_if_supported("declaration", "n", "gD",
    "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap_if_supported("goto_definition", "n", "<c-]>",
    "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap_if_supported("hover", "n", "K",
    "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap_if_supported("implementation", "n", "gi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap_if_supported("signature_help", "n", "gK",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap_if_supported("type_definition", "n", "gt",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap_if_supported("rename", "n", "g/",
    "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap_if_supported("find_references", "n", "gr",
    "<cmd>lua require(\"telescope.builtin\").lsp_references()<CR>",
    opts)

  buf_set_keymap_if_supported("code_action", "n", ";af",
    "<cmd>lua require(\"telescope.builtin\").lsp_code_actions()<CR>",
    opts)
  buf_set_keymap_if_supported("code_action", "v", ";af",
    "<cmd>lua require(\"telescope.builtin\").lsp_range_code_actions()<CR>",
    opts)
  buf_set_keymap_if_supported("workspace_symbol", "n", ";as",
    "<cmd>lua require(\"telescope.builtin\").lsp_workspace_symbols()<CR>",
    opts)
  buf_set_keymap_if_supported("workspace_symbol", "n", ";ad",
    "<cmd>lua require(\"telescope.builtin\").lsp_dynamic_workspace_symbols()<CR>",
    opts)

  buf_set_keymap_if_supported("document_formatting", "n", "==",
    "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap_if_supported("document_range_formatting", "v", "==",
    "<cmd>lua vim.lsp.buf.range_formatting()<CR>",
    opts)

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
    {severity_sort = true})

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
  end
end

return M
