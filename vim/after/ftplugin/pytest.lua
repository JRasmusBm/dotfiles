local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local sn = ls.snippet_node
local i = ls.insert_node

vim.g["test#python#runner"] = "pytest"

print(vim.g["test#python#pytest#executable"])
if vim.g["test#python#pytest#executable"] == nil then
  vim.g["test#python#pytest#executable"] = "python -m pytest"

  vim.g["test#python#pytest#options"] = {
    nearest = "--log-level WARNING --no-cov --disable-warnings -vv",
    file = "--log-level WARNING --no-cov --disable-warnings -vv",
    suite = "-vv",
  }
end

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

ls.add_snippets("pytest", {
  s(
    { trig = "ds", name = "Test suite" },
    fmt(
      [[
class Test{}:
    @staticmethod
    def test_{}():
        {}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "dc", name = "Test case" },
    fmt(
      [[
@staticmethod
def test_{}():
    {}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "de", name = "Expect equals" },
    fmt(
      [[
assert {}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "db", name = "Pytest fixture" },
    fmt(
      [[
@pytest.fixture
def {}({}){}:
    {}
  ]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "der", name = "expect raises regex" },
    fmt(
      [[
with pytest.raises({}, match="{}"):
  {}
]],
      { i(1), i(2), i(0) }
    )
  ),
})
