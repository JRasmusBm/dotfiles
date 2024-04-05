vim.cmd [[
command! PR norm gg/Ticketf[yi]/#f[v2f]p0WysaW]Wdw
]]

local function with_textobject(action)
  return function()
    local old_func = vim.go.operatorfunc
    _G.op_func_helper = function()
      _G.op_func_helper = nil
      vim.go.operatorfunc = old_func
      local start = vim.api.nvim_buf_get_mark(0, "[")
      local end_ = vim.api.nvim_buf_get_mark(0, "]")
      action(start, end_)
    end
    vim.go.operatorfunc = "v:lua.op_func_helper"
    vim.api.nvim_feedkeys("g@", "n", false)
  end
end

local replace_in_textobject = function(regex_)
  return with_textobject(function(start_position, end_position)
    vim.cmd(
      "silent keeppatterns"
      .. start_position[1]
      .. ","
      .. end_position[1]
      .. regex_
    )
  end)
end

vim.keymap.set(
  { "n" },
  ";c",
  replace_in_textobject "s/\\[ ]/[x]/",
  { noremap = true }
)
vim.keymap.set(
  { "n" },
  ";C",
  replace_in_textobject "s/\\[x]/[ ]/",
  { noremap = true }
)

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }
vim.opt_local.wrap = true
vim.b.is_markdown_file = true
vim.opt_local.textwidth = 80

require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
  s(
    { trig = "acea", name = "" },
    fmt(
      [[
## Analysis

### What is the purpose of your document?

{}

### Who is your audience?

{}

#### What do they know?

{}

#### What do they need to know?

{}

### What are the right facts for the document?

{}
]],
      {
        i(
          1,
          "<!-- What do you want this document to accomplish? (Dig deep!) -->"
        ),
        i(2),
        i(3),
        i(4),
        i(0),
      }
    )
  ),

  s(
    { trig = "acec", name = "craft" },
    fmt(
      [[
## Craft

### Transcribe Your Purpose Statement

<!-- This comes from your handwritten analysis phase notes onto your draft page -->

{}

### Craft the Body

<!--
1.  Transcribe the relevant facts for your document that you selected in the analysis phase.
2.  Craft the body with the first words that come to mind; you’ll edit later.
3.  Hold off on detail work. However, do highlight or note incomplete or troublesome sections.
-->

{}

### Craft the Conclusion

<!--
- The conclusion should be simple but specific:
  1.  The conclusion should review the main points of the document.
  2.  The conclusion should tell the reader "now what."
-->

{}

### Craft the Introduction

<!--
1.  The introduction should contain the purpose statement.
2.  The introduction should also provide a preview of what the document will do/contain.
!-->

{}
]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "toc", name = "Table of Contents" },
    ls_utils.fill_command {
      "mdtoc",
      vim.fn.expand "%",
    }
  ),
})

ls_utils.load_shared { filetype = "markdown", shared = "markdown" }
