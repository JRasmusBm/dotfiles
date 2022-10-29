local M = {}

M.ensure_setup = function()
  if not require("jrasmusbm.utils").ensure_setup "nvim-treesitter-context" then
    return
  end

  require("treesitter-context").setup {
    max_lines = 0,
    trim_scope = "outer",
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        "class",
        "function",
        "method",
        "for",
        "while",
        "if",
        "switch",
        "case",
      },
      -- Patterns for specific filetypes
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      tex = {
        "chapter",
        "section",
        "subsection",
        "subsubsection",
      },
      rust = {
        "impl_item",
        "struct",
        "enum",
      },
      scala = {
        "object_definition",
      },
      vhdl = {
        "process_statement",
        "architecture_body",
        "entity_declaration",
      },
      markdown = {
        "section",
      },
      elixir = {
        "anonymous_function",
        "arguments",
        "block",
        "do_block",
        "list",
        "map",
        "tuple",
        "quoted_content",
      },
      json = {
        "pair",
      },
      yaml = {
        "block_mapping_pair",
      },
    },
  }
end

return M
