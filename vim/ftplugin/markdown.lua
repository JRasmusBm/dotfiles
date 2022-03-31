vim.cmd [[
command! PR norm gg/Ticketf[yi]/#f[v2f]p0WysaW]Wdw
]]

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.wrap = true
vim.b.is_markdown_file = true
vim.opt_local.textwidth = 80

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

-- TODO turn into snippets
vim.keymap.set({ "i" }, "<leader>bn", "<Esc>?^ *- <CR>:noh<CR>yy0}PWc$", { buffer = 0 })
vim.keymap.set({ "i" }, "<leader>cn", "<Esc>?^ *- [<CR>:noh<CR>yy0f]d$a]", { buffer = 0 })
vim.keymap.set({ "i" }, "<leader>nn", "<Esc>?^ *[0-9]<CR>:noh<CR>yy0}P<C-A>Wc$", { buffer = 0 })
vim.keymap.set(
  { "i" },
  "<leader>tr",
  "<Esc>}kyyp<cmd>s/|.*|/| <++> |/g<CR><Esc>{<cmd>call bushels#forward_marker(1)<CR>",
  { buffer = 0 }
)
vim.keymap.set(
  { "i" },
  "<leader>tc",
  "<Esc>?---<CR>k<c-v>$}k$A <++> |nV:s/<++>/---/g<CR>{<cmd>call bushels#forward_marker(1)<CR>",
  { buffer = 0 }
)

ls.snippets.markdown = {
  s(
    { trig = "bl", name = "bullet list" },
    fmt(
      [[
- {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "cl", name = "checkbox list" },
    fmt(
      [[
- [ ] {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "nl", name = "numbered list" },
    fmt(
      [[
1. {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "h1", name = "Header 1" },
    fmt(
      [[
# {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "h2", name = "Header 2" },
    fmt(
      [[
## {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "h3", name = "Header 3" },
    fmt(
      [[
### {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "h4", name = "Header 4" },
    fmt(
      [[
#### {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "h5", name = "Header 5" },
    fmt(
      [[
##### {}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fcv", name = "frontmatter cv" },
    fmt(
      [[
---
Duration: {}
Company: {}
Project: {}
Industry: {}
---

# Company Description

# Project Description

# Roles

## {}
]],
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),

  s({ trig = "li", name = "link" }, fmt("[{}]({}){}", { i(2), i(1), i(0) })),

  s({ trig = "im", name = "image" }, fmt("![{}]({}){}", { i(2), i(1), i(0) })),

  s({ trig = "rr", name = "reference" }, fmt("[{}]: {}", { i(1), i(0) })),

  s({ trig = "em", name = "emphasize" }, fmt("*{}*{}", { i(1), i(0) })),

  s({ trig = "bf", name = "bold face" }, fmt("**{}**{}", { i(1), i(0) })),

  s({ trig = "st", name = "strikethrough" }, fmt("~~{}~~{}", { i(1), i(0) })),

  s(
    { trig = "t1", name = "table 1" },
    fmt(
      [[
 | {} |
 |------|
 | {} |

  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "qu", name = "quote" },
    fmt(
      [[
> {}

{}
]],
      { i(1), i(0) }
    )
  ),
}
