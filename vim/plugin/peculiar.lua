local nmap = function(keys, command)
  require("jrasmusbm.utils").ensure_setup "vim-peculiar"
  vim.keymap.set({ "n" }, keys, command, {})
end

nmap("<localleader>v", "<Plug>PeculiarV")
nmap("<localleader>g", "<Plug>PeculiarG")
nmap("<localleader>n", "<Plug>PeculiarN")
nmap("<localleader>r", "<Plug>PeculiarR")

vim.g["peculiar#suppress_highlight_n"] = 1
