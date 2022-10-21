vim.cmd[[
nnoremap <buffer> ;af gg:%! bibclean -no-check-values
]]

 local ls = require "luasnip"
 local s = ls.s
 local fmt = require("luasnip.extras.fmt").fmt
 local ls_utils = require "jrasmusbm.snippets.utils.init"
 local i = ls.insert_node
 local d = ls.dynamic_node
 local t = ls.text_node
 local rep = require("luasnip.extras").rep

 ls.add_snippets("bib", {
  s({ trig=s", name="bib source" }, fmt([[
@{} {{
  {},
  {}="{}",
}}
{}
  ]], { i(1), i(2), i(3), i(4), i(0) })),
   

s({ trig="f", name="source field" }, fmt([[
{}="{}",{}
]], { i(1), i(2), i(0) })),

 })  
