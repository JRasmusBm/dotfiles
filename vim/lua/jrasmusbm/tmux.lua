local M = {}

local filetype_handlers = {
  javascript = "node %s",
  python = "python %s",
  sh = "sh %s",
  rust = "cargo run %s",
  typescript = "ts-node %s",
  go = "go run %s",
  terraform = "terraform apply",
}

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

  vim.keymap.set({ "n" }, "<localleader>tp", function()
    require("nvim-tmux-runner").repeat_last_selection()
  end)

  vim.keymap.set({ "n" }, "<localleader>tv", function()
    require("nvim-tmux-runner").go_to_last_selection()
  end)

  vim.keymap.set({ "n" }, "<localleader>tf", function()
    local handler = filetype_handlers[vim.bo.filetype]

    if handler == nil then
      print(string.format("No handler found for %s", vim.bo.filetype))
      return
    end

    require("nvim-tmux-runner").send_lines_to_runner {
      string.format(handler, vim.api.nvim_buf_get_name(0)),
    }
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

  vim.keymap.set({ "n" }, "<localleader>td", function()
    require("nvim-tmux-runner").send_special_to_runner "C-d"
  end)

  vim.keymap.set({ "n" }, "<localleader>tc", function()
    require("nvim-tmux-runner").send_special_to_runner "C-c"
  end)

  vim.keymap.set({ "n" }, "<localleader>to", function()
    local cmd = {
      "tmux",
      "split-window",
      "-h",
    }
    vim.system(cmd):wait()
    require("nvim-tmux-runner").attach { pane = 1 }
    vim.system({ "tmux", "last-pane" }):wait()
  end)

  vim.keymap.set({ "n" }, "<localleader>tj", function()
    local cmd = {
      "tmux",
      "split-window",
    }
    vim.system(cmd):wait()
    require("nvim-tmux-runner").attach { pane = 1 }
    vim.system({ "tmux", "last-pane" }):wait()
  end)

  vim.keymap.set({ "v" }, "<localleader>ts", function()
    vim.schedule(function()
      local start_position = vim.api.nvim_buf_get_mark(0, "<")
      local end_position = vim.api.nvim_buf_get_mark(0, ">")

      require("nvim-tmux-runner").send_selection_to_runner(
        start_position,
        end_position
      )
    end)
  end)
end

return M
