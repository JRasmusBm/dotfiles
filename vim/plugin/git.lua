require("jrasmusbm.utils").ensure_setup("gitsigns.nvim")
require('gitsigns').setup(
{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})
  end
}
)
require("jrasmusbm.utils").ensure_setup "nvim-web-devicons"

vim.cmd [[
command! -nargs=? L silent call jrasmusbm#git#open_tree(<f-args>)

command! Gpa call jrasmusbm#git#push_all()
]]

vim.g.diffopt = require("jrasmusbm.utils.options").list {
  "filler",
  "context:3",
  "iwhiteall",
  "internal",
  "hiddenoff",
}
vim.g.fugitive_git_executable = "g"

vim.g.fugitive_gitlab_domains = {}

vim.api.nvim_create_user_command("G", function(options)
  require("jrasmusbm.utils").ensure_setup "vim-rhubarb"
  require("jrasmusbm.utils").ensure_setup "fugitive-gitlab.vim"
  require("jrasmusbm.utils").ensure_setup "vim-fugitive"

  require("jrasmusbm.git").run_command(options)
end, { nargs = "*", bang = true, range = true })

vim.keymap.set({ "n", "x" }, "<leader>h", function()
  require("jrasmusbm.git").open_github_link()
end)
