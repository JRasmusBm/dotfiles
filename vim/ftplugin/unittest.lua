local mappings = require("jrasmusbm.utils.mappings")
local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local sn = ls.snippet_node
local i = ls.insert_node

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

local test_class = function()
  return fmt("class Test{}(unittest.TestCase):\n    {}", {i(1), i(0)})
end

local test_case = function()
  return fmt("def test_{}(self) -> None:\n    {}\n\n{}", {i(1), i(2), i(0)})
end

ls.snippets.unittest = {
  s({trig = "df", name = "Test file"}, {
    sn(1, fmt("import unittest\n\n{}", {i(0)})),
    sn(2, test_class()),
    sn(3, test_case()),
    i(0),
  }),
  s({trig = "ds", name = "Test suite"},
    {sn(1, test_class()), sn(0, test_case())}),

  s({trig = "dc", name = "Test case"}, test_case()),

  s({trig = "de", name = "Expect equals"},
    fmt("self.assertEquals({}, {}):\n{}", {i(1), i(2), i(0)})),
  s({trig = "der", name = "Expect raises regex"},
    fmt("with self.assertRaisesRegex({}, \"{}\"):\n    {}", {i(1), i(2), i(0)})),
}
