local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.add_snippets("hugo", {
  s(
    { trig = "ht", name = "hugo tag" },
    fmt(
      [[
{{{{ {} }}}}
{}
{{{{ end }}}}
{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),
})

vim.keymap.set({ "n" }, "==", "<cmd>%!pret --parser=go-template<cr>", {})
