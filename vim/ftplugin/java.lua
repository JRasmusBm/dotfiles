vim.cmd [[
nnoremap <buffer> <leader>p :FormatCode<cr>
]]

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.add_snippets("java", {
  s({ trig="cd", name="class definitiom" }, fmt([[
public class {} {{
  {}
}}
  ]], { i(1), i(0) })),

s({ trig="pkg", name="package" }, fmt([[
package {};
{}
]], { i(1), i(0) })),

s({ trig="id", name="import default" }, fmt([[
import {};
{}
]], { i(1), i(0) })),

  
})  
