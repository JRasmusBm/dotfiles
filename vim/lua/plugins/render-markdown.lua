return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = { "markdown" },
    -- Its default cmp source loads cmp on every markdown open; the
    -- in-process LSP reaches cmp through nvim_lsp instead.
    completions = { lsp = { enabled = true } },
  },
  ft = { "markdown" },
}
