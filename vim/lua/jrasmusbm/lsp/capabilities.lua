return {
  { name = "declaration", handler = vim.lsp.buf.declaration, mapping = "gD" },
  {
    name = "goto_definition",
    handler = vim.lsp.buf.definition,
    mapping = "<c-]>",
  },
  { name = "hover", handler = vim.lsp.buf.hover, mapping = "K" },
  {
    name = "implementation",
    handler = vim.lsp.buf.implementation,
    mapping = "gi",
  },
  {
    name = "signature_help",
    handler = vim.lsp.buf.signature_help,
    mapping = "gK",
  },
  {
    name = "type_definition",
    handler = vim.lsp.buf.type_definition,
    mapping = "gt",
  },
  { name = "rename", handler = vim.lsp.buf.rename, mapping = "g/" },
  {
    name = "find_references",
    handler = require("telescope.builtin").lsp_references,
    mapping = "gr",
  },
  {
    name = "code_action",
    handler = require("telescope.builtin").lsp_code_actions,
    mapping = ";af",
  },
  {
    name = "code_action",
    handler = require("telescope.builtin").lsp_range_code_actions,
    mapping = ";af",
    modes = { "v" },
  },
  {
    name = "workspace_symbol",
    handler = require("telescope.builtin").lsp_workspace_symbols,
    mapping = ";as",
  },
  {
    name = "workspace_symbol",
    handler = require("telescope.builtin").lsp_dynamic_workspace_symbols,
    mapping = ";ad",
  },
  {
    name = "document_formatting",
    handler = function()
      vim.lsp.buf.format { async = true }
    end,
    mapping = "==",
  },
  {
    name = "document_range_formatting",
    handler = vim.lsp.buf.range_formatting,
    mapping = "==",
    modes = { "v" },
  },
}
