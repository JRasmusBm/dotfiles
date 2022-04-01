local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.snippets.typescript_jest = {
  s({ trig = "ds", name = "test suite" }, {
    t { 'describe("' },
    i(1),
    t { '", (): void => {', "\t" },
    t { 'it("' },
    i(2),
    t { '", async (): Promise<void> => {', "\t\t" },
    i(3, 'throw "Not implemented!"'),
    t { "", "\t" },
    t { "})", "\t" },
    t { "", "\t" },
    i(0),
    t { "", "" },
    t { "})" },
  }),
  s({ trig = "dc", name = "test case" }, {
    t { 'it("' },
    i(1),
    t { '", async (): Promise<void> => {', "\t" },
    i(0, 'throw "Not implemented!"'),
    t { "", "" },
    t { "})" },
  }),

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
}
