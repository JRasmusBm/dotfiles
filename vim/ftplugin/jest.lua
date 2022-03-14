local ls = require "luasnip"
local s = ls.s
local i = ls.insert_node
local ls_utils = require "jrasmusbm.snippets.utils.init"

local t = ls.text_node

ls.snippets.jest = {
  s({ trig = "ds", name = "test suite" }, {
    t { 'describe("' },
    i(1),
    t { '", async () => {', "\t" },
    t { 'it("' },
    i(2),
    t { '", async () => {', "\t\t" },
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
    t { '", async () => {', "\t" },
    i(0, 'throw "Not implemented!"'),
    t { "", "" },
    t { "})" },
  }),
}

ls_utils.load_shared(ls.snippets.jest, "jest")
