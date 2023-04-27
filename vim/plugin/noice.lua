require("jrasmusbm.utils").ensure_setup "nui.nvim"
require("jrasmusbm.utils").ensure_setup "nvim-notify"
require("jrasmusbm.utils").ensure_setup "noice.nvim"

require("noice").setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
}
