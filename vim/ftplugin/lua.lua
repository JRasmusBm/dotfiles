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
  s({trig = "im", name = "import module"},
    fmt("local {} = require('{}')\n{}", {i(1), rep(1), i(0)})),

  s({trig = "lf", name = "lua file"},
    fmt("local M = {{}}\n\n{}\n\nreturn M{}", {i(1), i(0)})),
  s({trig = "lb", name = "log breakpoint"}, {
    t {"print(", "\t"},
    t {"vim.inspect({", "\t\t"},
    t("file = \""),
    d(1, ls_utils.file_name, {}),
    t {"\",", "\t\t"},
    t("line = "),
    d(2, ls_utils.line_number, {}),
    t {",", "\t\t"},
    i(3),
    t {"", "\t"},
    t {"})", ""},
    t ")",
    i(0),
  }),

  s({trig = "vl", name = "local variable"},
    fmt("local {} = {}\n{}", {i(1), i(2), i(0)})),
  s({trig = "ve", name = "exported variable"},
    fmt("M.{} = {}\n{}", {i(1), i(2), i(0)})),

  s({trig = "fd", name = "function definition"},
    fmt("function {}({})\n  {}\nend\n\n{}", {i(1), i(2), i(3), i(0)})),

  s({trig = "ci", name = "if statement"},
    fmt("if {} then\n  {}\nend\n\n{}", {i(1), i(2), i(0)})),
  s({trig = "cf", name = "for loop"}, fmt(
      "for {}, {} in {} do\n  {}\nend\n\n{}",
      {i(1, "_"), i(2), i(3), i(4), i(0)})),

  s({trig = "vc", name = "vim command"},
    fmt("vim.cmd[[\n{}\n]]\n\n{}", {i(1), i(0)})),

  s({trig = "im", name = "import module"},
    fmt("local mappings = require(\"jrasmusbm.utils.mappings\")\n{}", {i(0)})),

  s({trig = "sn", name = "create snippet"},
    fmt("s({{ trig=\"{}\", name=\"{}\" }}, fmt(\"{}\", {{ {} }})),\n{}",
        {i(1), i(2), i(3), i(4), i(0)})),
  s({trig = "snf", name = "snippet file"}, {
    t {"local ls = require(\"luasnip\")", ""},
    t {"local s = ls.s", ""},
    t {"local fmt = require(\"luasnip.extras.fmt\").fmt", ""},
    t {"local ls_utils = require(\"jrasmusbm.snippets.utils.init\")", ""},
    t {"local i = ls.insert_node", ""},
    t {"local d = ls.dynamic_node", ""},
    t {"local t = ls.text_node", ""},
    t {"local rep = require(\"luasnip.extras\").rep", ""},
    t {"", ""},
    t "ls.snippets.",
    i(0),
  }),

  s({trig = "an", name = "named argument"},
    fmt("{} = {},{}", {i(1), rep(1), i(0)})),

  s({trig = "mk", name = "map keys"},
    fmt("vim.keymap.set({{ \"{}\" }}, \"{}\", {}, {{ {} }})\n{}",
        {i(1), i(2), i(3), i(4), i(0)})),
}

