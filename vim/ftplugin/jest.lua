local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node

local t = ls.text_node

ls.snippets.jest = {
  s({trig = "ds", name = "test suite"}, {
    t {"describe(\""},
    i(1),
    t {"\", async () => {", "\t"},
    t {"it(\""},
    i(2),
    t {"\", async () => {", "\t\t"},
    i(3, "throw \"Not implemented!\""),
    t {"", "\t"},
    t {"})", "\t"},
    t {"", "\t"},
    i(0),
    t {"", ""},
    t {"})"},
  }),
  s({trig = "dc", name = "test case"}, {
    t {"it(\""},
    i(1),
    t {"\", async () => {", "\t"},
    i(0, "throw \"Not implemented!\""),
    t {"", ""},
    t {"})"},
  }),
}

require("plenary.reload").reload_module("jrasmusbm.snippets.shared.jest")

for _, snippet in pairs(require("jrasmusbm.snippets.shared.jest")) do
  table.insert(ls.snippets.jest, snippet())
end
