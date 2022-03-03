vim.cmd [[
execute "source $DOTFILES/vim/snippets/sql.vim"
]]

vim.fn.setreg("n", "dt,nvgnpdf @n")
vim.fn.setreg("c", "/\\v\\%s\n$i,0l@n")

vim.keymap.set({"n"}, "==", function()
  vim.cmd [[
    %!sqlformat - -k upper -r --indent_columns --wrap_after 60
  ]]
end, {silent = true, buffer = 0})

vim.keymap.set({ "n" }, ";c", "", {  })
vim.g.VtrStripLeadingWhitespace = 0

vim.opt.formatprg = "sqlformat - -k upper -r --indent_columns --wrap_after 60"

