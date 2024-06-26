local M = {}

M.setup = function()
  vim.keymap.set({ "n" }, "<localleader>ta", function()
    local target = require("nvim-tmux-runner").get_target()

    if target.window == nil then
      require("nvim-tmux-runner").attach { window = "cli", pane = 0 }
    else
      require("nvim-tmux-runner").attach { pane = 1 }
    end

    print("Target: " .. require("nvim-tmux-runner").get_target_string())
  end)

  vim.keymap.set({ "n" }, "<localleader>tt", function()
    require("nvim-tmux-runner").focus_target()
  end)

  vim.keymap.set({ "n" }, "<localleader>tf", function()
    require("nvim-tmux-runner").send_file_to_runner()
  end)

  vim.keymap.set({ "n" }, "<localleader>tl", function()
    require("nvim-tmux-runner").send_lines_to_runner({
      vim.api.nvim_get_current_line(),
    }, true)
  end)

  vim.keymap.set(
    { "n" },
    "<localleader>ts",
    require("jrasmusbm.utils.mappings").with_textobject(
      function(start_position, end_position)
        require("nvim-tmux-runner").send_selection_to_runner(
          start_position,
          end_position
        )
      end
    )
  )
end

return M
