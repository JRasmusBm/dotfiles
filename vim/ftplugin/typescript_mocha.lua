local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local t = ls.text_node

vim.g["test#javascript#runner"] = "mocha"
vim.g["test#javascript#mocha#options"] = {
  nearest = "--reporter-option maxDiffSize=0",
  file = "--reporter-option maxDiffSize=0",
  suite = "--reporter-option maxDiffSize=0",
}

require("jrasmusbm.dap.test").setup_test_debugging(
  {
    ["test#javascript#mocha#executable"] = "node --inspect-brk ./node_modules/.bin/mocha",
  },
  vim.schedule_wrap(function()
    vim.defer_fn(function()
      require("dap").run(require("jrasmusbm.dap.node").configuration_factory {})
    end, 500)
  end)
)

ls.add_snippets("typescript_mocha", {
  s(
    { trig = "is", name = "import sinon" },
    fmt('import * as sinon from "sinon"\n{}', { i(0) })
  ),

  s({ trig = "ds", name = "test suite" }, {
    t { 'describe("' },
    i(1),
    t { '", async function(): Promise<void> {', "\t" },
    t { 'it("' },
    i(2),
    t { '", async function(): Promise<void> {', "\t\t" },
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
    t { '", async function() Promise<void> {', "\t" },
    i(0, 'throw "Not implemented!"'),
    t { "", "" },
    t { "})" },
  }),

  s(
    { trig = "db", name = "test case" },
    fmt(
      "beforeEach(async function(): Promise<void> {{\n  {}\n}}){}\n",
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
    { trig = "de", name = "expect (deep) equal" },
    fmt("expect({}).to.deep.equal({})\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "lm", name = "mock logging" },
    fmt('sinon.replace(console, "{}", sinon.fake())\n{}', { i(1), i(0) })
  ),
})
