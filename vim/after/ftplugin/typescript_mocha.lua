local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

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

  s(
    { trig = "ds", name = "test suite" },
    fmt(
      [[
describe("{}", function () {{
  it("{}", async function () {{
    // given
    // when
    // then
    throw "Not implemented!";
  }});
}})
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "dc", name = "test case" },
    fmt(
      [[
it("{}", async function () {{
  // given
  // when
  // then
  throw "Not implemented!";
}});
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "db", name = "test setup" },
    fmt(
      [[
beforeEach(function() {{
  {}
}})
]],
      { i(0) }
    )
  ),

  s(
    { trig = "db", name = "test teardown" },
    fmt(
      [[
afterEach(function() {{
  {}
}})
]],
      { i(0) }
    )
  ),

  s(
    { trig = "dec", name = "expect called" },
    fmt(
      [[
const calls = {}.getCalls()
expect(calls).to.have.length(1)
expect(calls[0].args).to.deep.equal([{{ {} }}])
]],
      { i(1), i(0) }
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

  s(
    { trig = "dms", name = "" },
    fmt(
      [[
sinon.stub({}, "{}");
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "dmc", name = "" },
    fmt(
      [[
let {}Stub: sinon.SinonStub<
  Parameters<typeof {}["{}"]>,
  ReturnType<typeof {}["{}"]>
>;
{}Stub = sinon.stub({}, "{}");
  ]],
      { rep(1), i(2), i(1), rep(2), rep(1), rep(1), rep(2), rep(1) }
    )
  ),
})
