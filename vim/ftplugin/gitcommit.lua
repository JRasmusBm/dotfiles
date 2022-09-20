require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"
local utils = require "telescope.utils"

vim.opt.textwidth = 72
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }

vim.keymap.set({ "i" }, "<Leader>c", require("jrasmusbm.mappings").finish_file)

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local f = ls.function_node

local fill_git_section = function(section_tag)
  return fmt(
    [[
{}
]],
    {
      f(function()
        return utils.get_os_command_output {
          "git",
          section_tag,
          "r",
          "p",
        }
      end, {}, {}),
    }
  )
end

ls.add_snippets("gitcommit", {
  s(
    { trig = "!f", name = "breaking feature" },
    fmt(
      [[
feat({})!: {}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "f", name = "feature" },
    fmt(
      [[
feat({}): {}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "b", name = "bug fix" },
    fmt(
      [[
fix({}): {}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "d", name = "documentation" },
    fmt(
      [[
docs({}): {}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "s", name = "style" },
    fmt(
      [[
style({}): {}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "r", name = "refactor" },
    fmt(
      [[
refactor({}): {}

{}
    ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "t", name = "test" },
    fmt(
      [[
test({}): {}

{}
    ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "c", name = "chore" },
    fmt(
      [[
chore({}): {}

{}
    ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ca", name = "Co-authored-by" },
    fmt(
      [[
Co-authored-by: {} <{}>
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ci", name = "Closes issue" },
    fmt(
      [[
Closes: #{}{}
  ]],
      {
        f(function()
          local branch_name = utils.get_os_command_output({
            "git",
            "branch",
            "--show-current",
          })[1]

          return string.match(branch_name, "^[0-9]+")
        end, {}, {}),
        i(0),
      }
    )
  ),

  s(
    { trig = "ct", name = "Closes ticket" },
    fmt(
      [[
Ticket: {}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "w", name = "why" },
    fmt(
      [[
**Why** is the change needed?

{}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "h", name = "how" },
    fmt(
      [[
**How** is the need addressed?

{}
]],
      { i(0) }
    )
  ),

  s(
    { trig = "con", name = "concerns" },
    fmt(
      [[
Concerns / side-effects of the changes:

{}
]],
      { i(0) }
    )
  ),

  s({ trig = "fw", name = "fill why" }, fill_git_section "why"),
  s({ trig = "fh", name = "fill how" }, fill_git_section "how"),
  s({ trig = "fc", name = "fill con" }, fill_git_section "con"),
})

ls_utils.load_shared { filetype = "gitcommit", shared = "markdown" }
