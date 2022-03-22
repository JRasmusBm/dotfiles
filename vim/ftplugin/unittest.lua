local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node

vim.g["test#python#runner"] = "pyunit"
vim.g["test#python#pyunit#executable"] = "python -m unittest"

require("jrasmusbm.dap.test").setup_test_debugging(
  {
    ["test#python#pyunit#executable"] = "python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m unittest",
  },
  vim.schedule_wrap(function()
    vim.defer_fn(function()
      vim.cmd "Debugpy attach 0.0.0.0 5678"
    end, 500)
  end)
)

local test_class = function()
  return fmt("class Test{}(unittest.TestCase):\n    {}", { i(1), i(0) })
end

local test_case = function()
  return fmt("def test_{}(self) -> None:\n    {}\n\n{}", { i(1), i(2), i(0) })
end

ls.snippets.unittest = {
  s({ trig = "df", name = "Test file" }, {
    sn(1, fmt("import unittest\n\n{}", { i(0) })),
    sn(2, test_class()),
    sn(3, test_case()),
    i(0),
  }),
  s({ trig = "ds", name = "Test suite" }, { sn(1, test_class()), sn(0, test_case()) }),

  s({ trig = "dc", name = "Test case" }, test_case()),

  s({ trig = "de", name = "Expect equal" }, fmt("self.assertEqual({}, {})\n{}", { i(1), i(2), i(0) })),
  s(
    { trig = "der", name = "Expect raises regex" },
    fmt('with self.assertRaisesRegex({}, "{}"):\n    {}', { i(1), i(2), i(0) })
  ),
  s(
    { trig = "dp", name = "Patch object" },
    fmt(
      [[
{}@patch("{}", new={})
]],
      {
        f(function()
          if not require("jrasmusbm.utils").has_line_matching "\\vfrom unittest.mock import .*<patch>" then
            vim.api.nvim_buf_set_lines(0, 2, 2, false, { "from unittest.mock import patch" })
          end

          return ""
        end, {}),
        i(1),
        i(0),
      }
    )
  ),
}
