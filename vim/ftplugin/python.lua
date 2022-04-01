vim.cmd [[
match BadWhitespace /\s\+$/
]]

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep

require "jrasmusbm.dap.python"

ls.snippets.python = {
  s(
    { trig = "doc", name = "docstring" },
    fmt(
      [[
"""
{}
"""
{}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "pf", name = "python (main) file" },
    fmt(
      [[
"""
{}
"""
import logging
logger = logging.getLogger(__name__)
def main():
  """
  {}
  """
  {}

if __name__ == "__main__":
    main()
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "fd", name = "function definition" },
    fmt("def {}({}):\n    {}\n\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "fi", name = "function inline" },
    fmt("lambda {}: {}", { i(1), i(0) })
  ),

  s({ trig = "al", name = "literal argument" }, fmt("{}, {}", { i(1), i(0) })),

  s(
    { trig = "vd", name = "variable definition" },
    fmt("{} = {}", { i(1), i(0) })
  ),
  s(
    { trig = "va", name = "instance variable assignment" },
    fmt("self.{} = {}", { i(1), i(0) })
  ),

  s(
    { trig = "tc", name = "type class" },
    fmt("class {}:\n    {}\n\n{}", { i(1), i(2), i(0) })
  ),

  s({ trig = "lf", name = "log format" }, fmt("pformat({}){}", { i(1), i(0) })),
  s(
    { trig = "ld", name = "log debug" },
    fmt("logger.debug({})\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "li", name = "log info" },
    fmt("logger.info({})\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "lw", name = "log warning" },
    fmt("logger.warning({})\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "le", name = "log error" },
    fmt("logger.error({})\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "lc", name = "log critical" },
    fmt("logger.critical({})\n{}", { i(1), i(0) })
  ),
  s({ trig = "ll", name = "print" }, fmt("print({})\n{}", { i(1), i(0) })),
  s(
    { trig = "lb", name = "log breakpoint" },
    fmt(
      [[
print(dict(
    file = "{}",
    line = {},
    {}
))
{}
  ]],
      {
        d(1, ls_utils.file_path, {}),
        d(2, ls_utils.line_number, {}),
        i(3),
        i(0),
      }
    )
  ),

  s(
    { trig = "an", name = "named argument" },
    fmt("{} = {}{},\n{}", { i(1), i(2), rep(1), i(0) })
  ),
  s(
    { trig = "at", name = "typed argument" },
    fmt("{}: {},\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "ad", name = "default argument" },
    fmt("{} = {},\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "atd", name = "typed default argument" },
    fmt("{}: {} = {},\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "au", name = "unused argument" },
    fmt("del {}  # Explicitly marked as unused\n{}", { i(1), i(0) })
  ),

  s(
    { trig = "oi", name = "object identifier" },
    fmt("__{}__{}", { i(1), i(0) })
  ),
  s(
    { trig = "om", name = "object method" },
    fmt("def __{}__({}):\n    {}\n\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "of", name = "object field" },
    fmt('"{}": {}{},\n{}', { i(1), i(2), rep(1), i(0) })
  ),

  s(
    { trig = "in", name = "named import" },
    fmt("from {} import {}\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "im", name = "module import" },
    fmt("import {}\n{}", { i(1), i(0) })
  ),

  s(
    { trig = "cw", name = "with statement" },
    fmt("with {}:\n    {}", { i(1), i(0) })
  ),
  s(
    { trig = "ci", name = "if statement" },
    fmt("if {}:\n    {}", { i(1), i(0) })
  ),
  s(
    { trig = "ce", name = "else statement" },
    fmt("else {}:\n    {}", { i(1), i(0) })
  ),
  s(
    { trig = "cei", name = "elif clause" },
    fmt("elif {}:\n    {}", { i(1), i(0) })
  ),
  s(
    { trig = "ct", name = "exception handler" },
    fmt("try:\n    {}\nexcept{}:\n    {}\n\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "cf", name = "for-each loop" },
    fmt("for {} in {}:\n    {}\n\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "cfr", name = "range loop" },
    fmt("for {} in range({}):\n    {}\n\n{}", { i(1, "i"), i(2), i(3), i(0) })
  ),

  s(
    { trig = "et", name = "ternary expression" },
    fmt("{} if {} else {}", { i(2), i(1), i(0) })
  ),
  s(
    { trig = "em", name = "list comprehension (map)" },
    fmt("[ {}{} for {} in {} ]{}", { rep(2), i(3), i(2), i(1), i(0) })
  ),
  s(
    { trig = "ef", name = "list comprehension (filter)" },
    fmt(
      "[ {} for {} in {} if {}{} ]{}",
      { rep(2), i(2), i(1), rep(2), i(3), i(0) }
    )
  ),
  s(
    { trig = "er", name = "list comprehension (reduce)" },
    fmt(
      "[ {}{} for {} in {} if {}{} ]{}",
      { rep(2), i(4), i(2), i(1), rep(2), i(3), i(0) }
    )
  ),
}
