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

mappings.nmap("<localleader>din",
              ":lua require(\"jrasmusbm.dap.python\").debug_test('TestNearest')<CR>",
              {noremap = true, buffer = true})
mappings.nmap("<localleader>dip",
              ":lua require(\"jrasmusbm.dap.python\").debug_test('TestLast')<CR>",
              {noremap = true, buffer = true})
mappings.nmap("<localleader>dif",
              ":lua require(\"jrasmusbm.dap.python\").debug_test('TestFile')<CR>",
              {noremap = true, buffer = true})
mappings.nmap("<localleader>dis",
              ":lua require(\"jrasmusbm.dap.python\").debug_test('TestSuite')<CR>",
              {noremap = true, buffer = true})
