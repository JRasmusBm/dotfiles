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
  return ls_utils.fill_command {
    "git",
    section_tag,
    "r",
    "p",
  }
end

local heading = function (severity, is_breaking)
local breaking_marker = ""
if (is_breaking)  then
  breaking_marker="!"
end

let about = i(1)
       local branch = utils.get_os_command_output {
          "git",
          --show-current,
        }
if () {
  
}





    return fmt(
 string.format     ([[
%s({})%s: {}

{}
  ]], severity, breaking_marker),
      { about, i(2), i(0) }
    )
    

  
end


local fill_git_section = function(section_tag)
  return
end

local fill_pr_info = function(field)
  fmt(
    [[
{}
]],
    {
      f(function()
        return utils.get_os_command_output {
          "get_pr_info",
          field,
        }
      end, {}, {}),
    }
  )
end

ls.add_snippets("gitcommit", {
  s(
    { trig = "!f", name = "breaking feature" },
      heading("feat", true)
  ),

  s(
    { trig = "f", name = "feature" },
      heading("feat")
  ),

  s(
    { trig = "b", name = "bug fix" },
      heading("fix")
  ),

  s(
    { trig = "d", name = "documentation" },
      heading("docs")

  ),

  s(
    { trig = "s", name = "style" },

      heading("style")
  ),

  s(
    { trig = "r", name = "refactor" },
            heading("refactor")

  ),

  s(
    { trig = "t", name = "test" },
      
      heading("test")
  ),

  s(
    { trig = "c", name = "chore" },

      heading("chore")
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
