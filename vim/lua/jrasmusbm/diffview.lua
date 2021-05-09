local cb = require'diffview.config'.diffview_callback
require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = true
  },
  key_bindings = {
    view = {
      ["]f"] = cb("select_next_entry"),
      ["[f"] = cb("select_prev_entry"),
      ["<tab>"] = cb("toggle_files"),
    },
    file_panel = {
      ["j"] = cb("next_entry"),
      ["k"] = cb("prev_entry"),
      ["<cr>"] = cb("select_entry"),
      ["o"]  = cb("select_entry"),
      ["R"]  = cb("refresh_files"),
      ["]f"] = cb("select_next_entry"),
      ["[f"] = cb("select_prev_entry"),
      ["<tab>"] = cb("toggle_files"),
    }
  }
}
