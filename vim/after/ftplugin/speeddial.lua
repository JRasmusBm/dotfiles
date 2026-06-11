vim.cmd [[
setlocal norelativenumber
setlocal number

augroup Speeddial
  autocmd!
  autocmd BufEnter <buffer> norm gg0
augroup END

nnoremap <silent> <buffer>  :wq
]]

-- In the `wt e` board (the worktrees order file), <CR> opens
-- the worktree on the current line and closes vim, so the pane
-- closes and the client lands in that session. Only bound for
-- the worktrees file — ts-* profiles and branch_speeddial
-- share this filetype but keep their default <CR>.
if vim.api.nvim_buf_get_name(0):match "/worktrees/[^/]+$" then
  vim.keymap.set("n", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    -- Skip blanks and section headings (# Foo / Foo:).
    if line:match "^%s*$" or line:match "^%s*#" or line:match ":%s*$" then
      return
    end
    -- Persist any reordering edits, then open + quit. `wt open`
    -- switches the client to the worktree's session before this
    -- returns, so quitting vim just closes the now-background
    -- `wt e` pane.
    vim.cmd "silent! update"
    vim.fn.system { "wt", "open", line }
    vim.cmd "quitall!"
  end, { buffer = true, silent = true, desc = "wt: open worktree on this line" })
end
