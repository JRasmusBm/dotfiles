vim.cmd[[
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/yaml.vim"

function! RunFile() abort
  w
  let path = shellescape(@%, 1)
  exec 'VtrSendCommandToRunner docker compose -f ' . path . ' down --remove-orphans'
  exec 'VtrSendCommandToRunner docker compose -f ' . path . ' up --remove-orphans --build'
endfunction

nnoremap <buffer> <leader>c :call RunFile()
]]

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.add_snippets("yaml", {
    s({ trig="vx", name="vpm next file" }, fmt([[
- ranges:
  - - {}
    - {}
  cursorLine: {}
]], { i(1), i(2), i(0) })),
    
  
})  
