local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local sn = ls.snippet_node
local i = ls.insert_node

vim.g["test#python#runner"] = "pytest"
vim.g["test#python#pytest#executable"] = "python -m pytest"

vim.g["test#python#pytest#options"] = {
   nearest= '--log-level WARNING --no-cov --disable-warnings -vv',
   file=    '--log-level WARNING --no-cov --disable-warnings -vv',
   suite=   '-vv',
}

require("jrasmusbm.dap.test").setup_test_debugging(
  {
    ["test#python#pytest#executable"] = "python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m pytest",
  },
  vim.schedule_wrap(function()
    vim.defer_fn(function()
      vim.cmd "Debugpy attach 0.0.0.0 5678"
    end, 500)
  end)
)

local test_class = function()
  return fmt("class Test{}:\n    {}", { i(1), i(0) })
end

local test_case = function()
  return fmt("def test_{}():\n    {}\n\n{}", { i(1), i(2), i(0) })
end

ls.add_snippets("pytest", {
  s(
    { trig = "df", name = "Test file" },
    { sn(1, test_class()), sn(2, test_case()), i(0) }
  ),
  s(
    { trig = "ds", name = "Test suite" },
    { sn(1, test_class()), sn(0, test_case()) }
  ),

  s({ trig = "dc", name = "Test case" }, test_case()),

  s({ trig = "de", name = "Expect equals" }, fmt("assert {}", { i(0) })),

  s(
    { trig = "db", name = "Pytest fixture" },
    fmt(
      "@pytest.fixture\ndef {}({}){}:\n    {}\n\n{}",
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),
})
