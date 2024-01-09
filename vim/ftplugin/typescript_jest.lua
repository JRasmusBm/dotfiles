local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

local t = ls.text_node
local rep = require("luasnip.extras").rep

vim.g["test#javascript#runner"] = "jest"

ls.add_snippets("typescript_jest", {
  s(
    { trig = "ds", name = "test suite" },
    fmt(
      [[
describe("{}", (): void => {{
  it("{}", async (): Promise<void> => {{
    // given
    // when
    // then
    throw "Not implemented!";
  }});

  {}
}});
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "dc", name = "test case" },
    fmt(
      [[
it("{}", async (): Promise<void> => {{
  // given
  // when
  // then
  throw "Not implemented!";
}});

{}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "dpm", name = "patch module" },
    fmt(
      [[
import {} from "{}"

jest.mock("{}")
  ]],
      { i(0), i(1), rep(1) }
    )
  ),

  s(
    { trig = "dpw", name = "wrapped mock" },
    fmt(
      [[
jest.mocked({}).{}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "dp", name = "mock function" },
    fmt(
      [[
jest.fn({})
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "dfc", name = "fire click event" },
    fmt(
      [[
fireEvent.click({})
{}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "db", name = "test case" },
    fmt(
      "beforeEach(async (): Promise<void> => {{\n  {}\n}}){}\n",
      { i(1, 'console.log("before")'), i(0) }
    )
  ),
  s(
    { trig = "dt", name = "test case" },
    fmt(
      "afterEach(async (): Promise<void> => {{\n  {}\n}}){}\n",
      { i(1, 'console.log("after")'), i(0) }
    )
  ),

  s(
    { trig = "dec", name = "expect called" },
    fmt(
      "const calls = {}.getCalls\nexpect(calls.to.have.length(1)\nexpect(calls[0].args).to.deep.equal([{{ {} }}]))\n{}",
      { i(1), i(2), i(0) }
    )
  ),
  s(
    { trig = "de", name = "expect equal" },
    fmt("expect({}).toEqual({})\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "lm", name = "mock logging" },
    fmt(
      "console.{} = jest.fn()\n{}\n;(console.{} as jest.Mock).mockClear()",
      { i(1), i(0), rep(1) }
    )
  ),
})
