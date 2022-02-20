vim.cmd [[
match BadWhitespace /\s\+$/
]]

local mappings = require("jrasmusbm.utils.mappings")
local ls = require("luasnip")
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local sn = ls.snippet_node
local ls_utils = require("jrasmusbm.snippets.utils.init")
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

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

local docstring =
  function() return fmt("\"\"\"\n{}\n\"\"\"\n{}", {i(1), i(0)}) end

local import_logging = function()
  return {
    t {"import logging", ""},
    t {"logger = logging.getLogger(__name__)", ""},
    i(0),
  }
end

local main_function = function()
  return {
    t {"def main():", "\t"},
    i(1),
    t {"", ""},
    t {"", ""},
    t {"if __name__ == \"__main__\":"},
    i(0),
    t {"", "\t"},
    t {"main()"},
  }
end

ls.snippets.python = {
  s({trig = "doc", name = "docstring"}, docstring()),
  s({trig = "pf", name = "python (main) file"},
    {sn(1, docstring()), sn(2, import_logging()), sn(3, main_function())}),

  s({trig = "fd", name = "function definition"},
    fmt("def {}({}):\n    {}\n\n{}", {i(1), i(2), i(3), i(0)})),
  s({trig = "fi", name = "function inline"}, fmt("lambda {}: {}", {i(1), i(0)})),

  s({trig = "al", name = "literal argument"}, fmt("{}, {}", {i(1), i(0)})),

  s({trig = "vd", name = "variable definition"}, fmt("{} = {}", {i(1), i(0)})),
  s({trig = "va", name = "instance variable assignment"},
    fmt("self.{} = {}", {i(1), i(0)})),

  s({trig = "tc", name = "type class"},
    fmt("class {}:\n    {}\n\n{}", {i(1), i(2), i(0)})),

  s({trig = "lf", name = "log format"}, fmt("pformat({}){}", {i(1), i(0)})),
  s({trig = "ld", name = "log debug"}, fmt("logger.debug({})\n{}", {i(1), i(0)})),
  s({trig = "li", name = "log info"}, fmt("logger.info({})\n{}", {i(1), i(0)})),
  s({trig = "lw", name = "log warning"},
    fmt("logger.warning({})\n{}", {i(1), i(0)})),
  s({trig = "le", name = "log error"}, fmt("logger.error({})\n{}", {i(1), i(0)})),
  s({trig = "lc", name = "log critical"},
    fmt("logger.critical({})\n{}", {i(1), i(0)})),
  s({trig = "ll", name = "print"}, fmt("print({})\n{}", {i(1), i(0)})),
  s({trig = "lb", name = "log breakpoint"}, {
    t {"print(dict(", "\t"},
    t("file = \""),
    d(1, ls_utils.file_name, {}),
    t {"\",", "\t"},
    t("line = "),
    d(2, ls_utils.line_number, {}),
    t {",", "\t"},
    i(3),
    t {"", ""},
    t {"))", ""},
    i(0),
  }),

  s({trig = "an", name = "named argument"},
    fmt("{} = {}{},\n{}", {i(1), i(2), rep(1), i(0)})),
  s({trig = "at", name = "typed argument"},
    fmt("{}: {},\n{}", {i(1), i(2), i(0)})),
  s({trig = "ad", name = "default argument"},
    fmt("{} = {},\n{}", {i(1), i(2), i(0)})),
  s({trig = "atd", name = "typed default argument"},
    fmt("{}: {} = {},\n{}", {i(1), i(2), i(3), i(0)})),
  s({trig = "au", name = "unused argument"},
    fmt("del {}  # Explicitly marked as unused\n{}", {i(1), i(0)})),

  s({trig = "oi", name = "object identifier"}, fmt("__{}__{}", {i(1), i(0)})),
  s({trig = "om", name = "object method"},
    fmt("def __{}__({}):\n    {}\n\n{}", {i(1), i(2), i(3), i(0)})),
  s({trig = "of", name = "object field"},
    fmt("\"{}\": {}{},\n{}", {i(1), i(2), rep(1), i(0)})),

  s({trig = "in", name = "named import"},
    fmt("from {} import {}\n{}", {i(1), i(2), i(0)})),
  s({trig = "im", name = "module import"}, fmt("import {}\n{}", {i(1), i(0)})),

  s({trig = "cw", name = "with statement"},
    fmt("with {}:\n    {}", {i(1), i(0)})),
  s({trig = "ci", name = "if statement"}, fmt("if {}:\n    {}", {i(1), i(0)})),
  s({trig = "ce", name = "else statement"},
    fmt("else {}:\n    {}", {i(1), i(0)})),
  s({trig = "cei", name = "elif clause"}, fmt("elif {}:\n    {}", {i(1), i(0)})),
  s({trig = "ct", name = "exception handler"},
    fmt("try:\n    {}\nexcept{}:\n    {}\n\n{}", {i(1), i(2), i(3), i(0)})),
  s({trig = "cf", name = "for-each loop"},
    fmt("for {} in {}:\n    {}\n\n{}", {i(1), i(2), i(3), i(0)})),
  s({trig = "cfr", name = "range loop"},
    fmt("for {} in range({}):\n    {}\n\n{}", {i(1, "i"), i(2), i(3), i(0)})),

  s({trig = "et", name = "ternary expression"},
    fmt("{} if {} else {}", {i(2), i(1), i(0)})),
  s({trig = "em", name = "list comprehension (map)"},
    fmt("[ {}{} for {} in {} ]{}", {rep(2), i(3), i(2), i(1), i(0)})),
  s({trig = "ef", name = "list comprehension (filter)"}, fmt(
      "[ {} for {} in {} if {}{} ]{}", {rep(2), i(2), i(1), rep(2), i(3), i(0)})),
  s({trig = "er", name = "list comprehension (reduce)"},
    fmt("[ {}{} for {} in {} if {}{} ]{}",
        {rep(2), i(4), i(2), i(1), rep(2), i(3), i(0)})),
}
