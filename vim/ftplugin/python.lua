vim.cmd [[
match BadWhitespace /\s\+$/

function! RunFile() abort
  w
  let path = shellescape(@%, 1)
  let module_path = join(split(split(path, '\.')[0], '/') , '.') . "'"
  echo module_path
  exec 'VtrSendCommandToRunner python -m ' . module_path
endfunction

execute "source $DOTFILES/vim/snippets/python.vim"
]]

local mappings = require("jrasmusbm.utils.mappings")

mappings.nmap("<localleader>di",
              ":lua require(\"jrasmusbm.dap.python\").debug_nearest()<CR>",
              {noremap = true})

mappings.nmap("<leader>ii", ":Debugpy attach 0.0.0.0 5678<CR>", {noremap = true})

mappings.nmap("<leader>c", ":call RunFile()<CR>",
              {noremap = true, buffer = true})
