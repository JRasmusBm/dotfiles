vim.opt_local.foldmethod = "marker"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

vim.keymap.set({ "v" }, "<localleader>tl", 'y:@"<CR>', { buffer = 0, noremap = true })
vim.keymap.set(
  { "n" },
  "<localleader>tl",
  "^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>",
  { buffer = 0, noremap = true }
)
vim.keymap.set({ "n" }, "<localleader>tf", "<cmd>so %<cr>", { buffer = 0, noremap = true })
vim.keymap.set({ "n" }, "zf", vim.fn["jrasmusbm#folds#fold_selection"], { expr = true })

ls.snippets.vim = {
  s({ trig = "fm", name = "forward marker" }, fmt(":call bushels#forward_marker({})<cr>{}", { i(1), i(0) })),
  s({ trig = "bm", name = "forward marker" }, fmt(":call bushels#forward_marker({})<cr>{}", { i(1), i(0) })),

  s(
    { trig = "fo", name = "open fold" },
    fmt(
      [[
" {} {{{{{{
{}
" }}}}}}
{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ci", name = "if statement" },
    fmt(
      [[
if {}
  {}
endif

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ag", name = "augroup" },
    fmt(
      [[
augroup {}
  autocmd!
  autocmd {}
  {}
augroup END

{}
]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "ac", name = "autocmd" },
    fmt(
      [[
autocmd {}
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "sn", name = "snippet" },
    fmt(
      [[
inoremap <buffer> <leader>{} {}
{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "pl", name = "plugin" },
    fmt(
      [[
packadd! {}
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fd", name = "function definition" },
    fmt(
      [[
function! {}() abort
  {}
endfunction

{}
]],
      { i(1), i(2), i(0) }
    )
  ),
}
