require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

vim.cmd [[
nnoremap <buffer> <localleader>tf :luafile %<CR>

nmap <buffer> <leader>me Imappings.f xys$)lysE"f r,lys])"$i, {}
nmap <buffer> <leader>mr 0f.2l4x$F{a noremap=true,<Space>
]]

require("jrasmusbm.treesitter.setup_mappings").main("<leader>ao", {
  {
    { "assignment_statement" },
    { { "variable_list", "name", "field" }, { "variable_list", "name" } },
  },
  { { "function_declaration" }, { { "name" } } },
}, true)

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.add_snippets("lua", {
  s(
    { trig = "im", name = "import module" },
    fmt("local {} = require('{}')\n{}", { i(1), rep(1), i(0) })
  ),

  s({ trig = "lb", name = "log breakpoint" }, {
    t { "print(", "\t" },
    t { "vim.inspect({", "\t\t" },
    t 'file = "',
    d(1, ls_utils.file_path, {}),
    t { '",', "\t\t" },
    t "line = ",
    d(2, ls_utils.line_number, {}),
    t { ",", "\t\t" },
    i(3),
    t { "", "\t" },
    t { "})", "" },
    t ")",
    i(0),
  }),

  s(
    { trig = "vl", name = "local variable" },
    fmt("local {} = {}\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "ve", name = "exported variable" },
    fmt("M.{} = {}\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "fi", name = "function inline" },
    fmt("function {}({})\n  {}\nend\n\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "fl", name = "local function" },
    fmt("local {} = function ({})\n  {}\nend\n\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "fe", name = "local function" },
    fmt("M.{} = function ({})\n  {}\nend\n\n{}", { i(1), i(2), i(3), i(0) })
  ),

  s(
    { trig = "ci", name = "if statement" },
    fmt("if {} then\n  {}\nend\n\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "cf", name = "for loop" },
    fmt(
      "for {}, {} in {} do\n  {}\nend\n\n{}",
      { i(1, "_"), i(2), i(3), i(4), i(0) }
    )
  ),

  s(
    { trig = "cfr", name = "range for loop" },
    fmt(
      "for {} = {}, {}, {} do\n  {}\nend\n\n{}",
      { i(1, "_"), i(2, "0"), i(3, "10"), i(4, "1"), i(5), i(0) }
    )
  ),

  s(
    { trig = "vc", name = "vim command" },
    fmt("vim.cmd[[\n{}\n]]\n\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "vcm", name = "vim mapped command" },
    fmt('require("jrasmusbm.utils.commands").run({}, options)', { i(0) })
  ),

  s(
    { trig = "sn", name = "snippet" },
    fmt(
      's({{ trig="{}", name="{}" }}, fmt([[\n{}\n]], {{ {} }})),\n{}',
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),
  s(
    { trig = "sns", name = "shared snippet" },
    fmt(
      'M.{} = function ()\n  return fmt("{}", {{ {} }})\nend\n\n{}',
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "snf", name = "snippet file" },
    fmt(
      [[
local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

ls.add_snippets("{}", {{
  {}
}})
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "st", name = "text node" },
    fmt('t {{"{}", "{}"}},\n{}', { i(1), i(2), i(0) })
  ),

  s({ trig = "i1", name = "one i(n)" }, fmt("i(0)", {})),
  s({ trig = "i2", name = "two i(n)" }, fmt("i(1), i(0)", {})),
  s({ trig = "i3", name = "three i(n)" }, fmt("i(1), i(2), i(0)", {})),
  s({ trig = "i4", name = "four i(n)" }, fmt("i(1), i(2), i(3), i(0)", {})),
  s(
    { trig = "i5", name = "four i(n)" },
    fmt("i(1), i(2), i(3), i(4), i(0)", {})
  ),
  s(
    { trig = "i6", name = "four i(n)" },
    fmt("i(1), i(2), i(3), i(4), i(5), i(0)", {})
  ),
  s(
    { trig = "i7", name = "four i(n)" },
    fmt("i(1), i(2), i(3), i(4), i(5), i(6), i(0)", {})
  ),
  s(
    { trig = "i8", name = "four i(n)" },
    fmt("i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(0)", {})
  ),
  s(
    { trig = "i9", name = "four i(n)" },
    fmt("i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(0)", {})
  ),

  s(
    { trig = "an", name = "named argument" },
    fmt("{} = {},{}", { i(1), rep(1), i(0) })
  ),

  s(
    { trig = "mk", name = "map keys" },
    fmt(
      'vim.keymap.set({{ "{}" }}, "{}", {}, {{ {} }})\n{}',
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),

  s(
    { trig = "vim-test-options", name = "vim-test-options" },
    fmt(
      [[
require("jrasmusbm.test_config.{}.{}").setup()
vim.g["test#{}#{}#executable"] = "{}"

vim.g["test#{}#{}#options"] = {{
   nearest= '{}',
   file=    '{}',
   suite=   '{}',
}}

require("jrasmusbm.dap.test").setup_test_debugging(
  {{
    ["test#{}#{}#executable"] = "{}",
  }},
  vim.schedule_wrap(function()
    vim.defer_fn(function()
      {}
      end, 500)
    end)
  )
      ]],
      {
        i(1, "python"),
        i(2, "pytest"),
        rep(1),
        rep(2),
        i(3, "python -m pytest"),
        rep(1),
        rep(2),
        i(4),
        i(5),
        i(6),
        rep(1),
        rep(2),
        i(7),
        i(8),
      }
    )
  ),

  s(
    { trig = "ag", name = "augroup" },
    fmt(
      [[
local {}_augroup = vim.api.nvim_create_augroup("{}", {{ clear=true }})
{}
]],
      { i(1), rep(1), i(0) }
    )
  ),

  s(
    { trig = "ac", name = "autocmd" },
    fmt(
      [[
vim.api.nvim_create_autocmd({{"{}"}}, {{
      group={},
      pattern={{{}}},
      callback=function()
        {}
      end,
}})
]],
      { i(2), i(1), i(3), i(0) }
    )
  ),

  s(
    { trig = "acll", name = "auto command line length" },
    fmt(
      [[
local project_files_augroup = vim.api.nvim_create_augroup("project_files", {{ clear = true }})

vim.api.nvim_create_autocmd({{ "BufNew", "BufNewFile", "BufRead" }}, {{
	group = project_files_augroup,
	pattern = {{ "*" }},
	callback = function()
		if vim.o.filetype == "gitcommit" then
		  return
		end

		vim.opt.textwidth = {}
	end,
}})

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ft", name = "change filetype" },
    fmt(
      [[
require("jrasmusbm.change_filetype").setup({{
  extensions = {{}},
  literal = {{}},
  complex = {{{}}},
  function_extensions = {{}},
  function_literal = {{}},
  function_complex = {{}},
  shebang = {{}},
}})
]],
      { i(0) }
    )
  ),

  s(
    { trig = "acr", name = "on read" },
    fmt([["BufNew", "BufNewFile", "BufRead"{}]], { i(0) })
  ),
  s({ trig = "ab", name = "" }, fmt([[vim.fn.expand("<abuf>"){}]], { i(0) })),
  s(
    { trig = "af", name = "<afile>" },
    fmt([[vim.fn.expand("<afile>"){}]], { i(0) })
  ),
  s(
    { trig = "am", name = "<amatch>" },
    fmt([[vim.fn.expand("<amatch>"){}]], { i(0) })
  ),

  s(
    { trig = "gib", name = "ignore git branch" },
    fmt(
      [[
vim.g["jrasmusbm#git#log_excludes"] = "--exclude=refs/remotes/origin/{}"
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "vcc", name = "create user command" },
    fmt(
      [[
vim.api.nvim_create_user_command("{}", function(options)
  require("jrasmusbm.{}").ensure_setup()

  {}
end, {{ nargs = "*" }})
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "es", name = "ensure setup" },
    fmt(
      [[
require("jrasmusbm.utils").ensure_setup("{}")
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "fk", name = "feedkeys" },
    fmt(
      [[
require("jrasmusbm.utils.mappings").feedkeys "{}"
]],
      { i(0) }
    )
  ),

  s(
    { trig = "hmk", name = "hammerspoon keymap" },
    fmt(
      [[
hs.hotkey.bind({{{}}}, "{}", function()
  {}
end)
]],
      { i(1), i(2), i(0) }
    )
  ),
})
