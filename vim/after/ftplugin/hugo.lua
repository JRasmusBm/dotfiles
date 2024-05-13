local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

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
