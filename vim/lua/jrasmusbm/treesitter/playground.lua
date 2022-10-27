local M = {}

M.ensure_setup = function ()
  require("jrasmusbm.treesitter").ensure_setup()  

  if require("jrasmusbm.utils").ensure_setup("nvim-treesitter-playground") then
    return
  end

  require("jrasmusbm.treesitter").ensure_setup()  

  require("nvim-treesitter.configs").define_modules({
      playground={

  enable = true,
  disable = {},
  updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  persist_queries = false, -- Whether the query persists across vim sessions
  keybindings = {
    toggle_query_editor = "o",
    toggle_hl_groups = "i",
    toggle_injected_languages = "t",
    toggle_anonymous_nodes = "a",
    toggle_language_display = "I",
    focus_language = "f",
    unfocus_language = "F",
    update = "R",
    goto_node = "<cr>",
    show_help = "?",
  },
      }
    })
end


return M
