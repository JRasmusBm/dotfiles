local ls = require("luasnip")
local s = ls.s
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

local test_suite = function(contents)
  return fmt("describe(\"{}\", async (): Promise<void> => {{\n  {}\n}}){}",
             {i(1, "sample suite"), sn(2, contents), i(0)})
end

local test_case = function()
  return fmt("it(\"{}\", async (): Promise<void> => {{\n  {}\n}})\n\n{}",
             {i(1, "sample test"), i(2, "throw \"Not implemented!\""), i(0)})
end

ls.snippets.typescript_mocha = {
  s({trig = "is", name = "import sinon"},
    fmt("import * as sinon from \"sinon\"\n{}", {i(0)})),

  s({trig = "dc", name = "test case"}, {sn(1, test_case())}),
  s({trig = "ds", name = "test case"}, test_suite(test_case())),

  s({trig = "db", name = "test case"},
    fmt("beforeEach(async (): Promise<void> => {{\n  {}\n}}){}\n",
        {i(1, "console.log(\"before\")"), i(0)})),
  s({trig = "dt", name = "test case"},
    fmt("afterEach(async (): Promise<void> => {{\n  {}\n}}){}\n",
        {i(1, "console.log(\"after\")"), i(0)})),

  s({trig = "dec", name = "expect called"}, fmt(
      "const calls = {}.getCalls\nexpect(calls.to.have.length(1)\nexpect(calls[0].args).to.deep.equal([{{ {} }}]))\n{}",
      {i(1), i(2), i(0)})),
  s({trig = "de", name = "expect (deep) equal"},
    fmt("expect({}).to.deep.equal({})\n{}", {i(1), i(2), i(0)})),

  s({trig = "lm", name = "mock logging"},
    fmt("sinon.replace(console, \"{}\", sinon.fake())\n{}", {i(1), i(0)})),
}
