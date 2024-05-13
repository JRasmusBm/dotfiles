require("plenary").reload.reload_module "jrasmusbm.snippets.utils.init"
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
local t = ls.text_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local heading = function(severity, breaking_marker)
  do
    return function(_, _)
      do
        local branch = utils.get_os_command_output({
          "git",
          "branch",
          "--show-current",
        })[1]

        local subject_section = (vim.split(branch, "/")[3] or "")
        local ticket_prefix = vim.split(subject_section, "-")[1] or ""
        if not vim.tbl_contains({ "pss", "pa" }, ticket_prefix) then
          return sn(
            0,
            fmt(
              string.format(
                [[
%s%s: {}

{}
  ]],
                severity,
                breaking_marker or ""
              ),
              { i(1), i(0) }
            )
          )
        end

        local ticket_id = vim.split(subject_section, "-")[2]
        return sn(
          0,
          fmt(
            string.format(
              [[
%s({})%s: {}

{}
  ]],
              severity,
              breaking_marker or ""
            ),
            {
              sn(1, { t { string.upper(ticket_prefix) .. "-" .. ticket_id } }),
              i(2),
              i(0),
            }
          )
        )
      end
    end
  end
end

ls.add_snippets("gitcommit", {
  s(
    { trig = "!f", name = "breaking feature" },
    { d(1, heading("feat", "!"), {}) }
  ),

  s({ trig = "f", name = "feature" }, { d(1, heading "feat", {}) }),
  s({ trig = "b", name = "bug fix" }, { d(1, heading "fix", {}) }),
  s({ trig = "d", name = "documentation" }, { d(1, heading "docs", {}) }),
  s({ trig = "s", name = "style" }, { d(1, heading "style", {}) }),
  s({ trig = "r", name = "refactor" }, { d(1, heading "refactor", {}) }),
  s({ trig = "t", name = "test" }, { d(1, heading "test", {}) }),
  s({ trig = "c", name = "chore" }, { d(1, heading "chore", {}) }),

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

  s(
    { trig = "fpt", name = "fill title" },
    ls_utils.fill_command {
      "get_pr_info",
      "title",
    }
  ),

  s(
    { trig = "fpn", name = "fill pr number" },
    ls_utils.fill_command {
      "get_pr_info",
      "number",
    }
  ),

  s(
    { trig = "fcn", name = "fill commit names" },
    ls_utils.fill_command { "git", "ccn", "no" }
  ),

  s(
    { trig = "fcr", name = "fill raw commit names" },
    ls_utils.fill_command { "git", "ccn", "raw" }
  ),

  s(
    { trig = "fw", name = "fill why" },
    ls_utils.fill_command { "git", "why", "r", "p" }
  ),

  s(
    { trig = "fh", name = "fill how" },
    ls_utils.fill_command { "git", "how", "r", "p" }
  ),

  s(
    { trig = "fc", name = "fill con" },
    ls_utils.fill_command { "git", "con", "r", "p" }
  ),
})

ls_utils.load_shared { filetype = "gitcommit", shared = "markdown" }
