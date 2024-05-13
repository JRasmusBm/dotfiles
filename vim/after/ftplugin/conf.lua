vim.cmd [[
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/conf.vim"
]]

vim.opt_local.foldmethod = "marker"

if vim.fn.expand "%:t" == "termux.conf" then
  vim.keymap.set({ "n" }, "<localleader>tf", function()
    vim.cmd "!termux-reload-settings"
  end, { buffer = 0 })
end
