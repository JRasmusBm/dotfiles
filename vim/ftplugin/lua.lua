vim.cmd [[
nnoremap <buffer> <localleader>tf :luafile %

nmap <buffer> <leader>me Imappings.f xys$)lysE"f r,lys])"$i, {}
nmap <buffer> <leader>mr 0f.2l4x$F{a noremap=true,<Space>
]]

local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require("jrasmusbm.snippets.utils.init")
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.snippets.lua = {
  s("im", fmt("local {} = require('{}')\n{}", {i(1), rep(1), i(0)})),

  s("lf", fmt("local M = {{}}\n\n{}\n\nreturn M{}", {i(1), i(0)})),
  s("ld", {
    t {"print(", "\t"},
    t {"inspect({", "\t\t"},
    t("file = "),
    d(1, ls_utils.file_name, {}),
    t {"", "\t\t"},
    t("line = "),
    d(2, ls_utils.line_number, {}),
    t {"", "\t\t"},
    i(3),
    t {"", "\t"},
    t {"})", ""},
    t ")",
    i(0),
  }),

  s("vl", fmt("local {} = {}\n{}", {i(1), i(2), i(0)})),
  s("ve", fmt("M.{} = {}\n{}", {i(1), i(2), i(0)})),

  s("fd", fmt("function {}({})\n  {}\nend\n\n{}", {i(1), i(2), i(3), i(0)})),

  s("ci", fmt("if {} then\n  {}\nend\n\n{}", {i(1), i(2), i(0)})),
  s("cf", fmt("for {}, {} in {} do\n  {}\nend\n\n{}",
              {i(1, "_"), i(2), i(3), i(4), i(0)})),

  s("vc", fmt("vim.cmd[[\n{}\n]]\n\n{}", {i(1), i(0)})),

  s("im",
    fmt("local mappings = require(\"jrasmusbm.utils.mappings\")\n{}", {i(0)})),

  s("sn", fmt("s(\"{}\", fmt(\"{}\", {{ {} }})),\n{}", {i(1), i(2), i(3), i(0)})),

  s("an", fmt("{} = {},{}", {i(1), rep(1), i(0)})),

  s("mk", fmt("vim.keymap.set({{ \"{}\" }}, \"{}\", function()\n {}\nend, {{ {} }})\n{}",
             {i(1), i(2), i(3), i(4), i(0)})),
}

