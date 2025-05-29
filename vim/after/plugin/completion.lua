local list = require("jrasmusbm.utils.options").list

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.complete = list { ".", "w", "b", "u", "kspell", "i" }
vim.opt.isfname = list {
  "@",
  "48-57",
  "/",
  ".",
  "-",
  "_",
  "+",
  ",",
  "#",
  "$",
  "%",
  "~",
  "=",
}

local cmp = require "cmp"

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(
      cmp.mapping.complete {
        config = { reason = cmp.ContextReason.Auto },
      },
      { "i", "c" }
    ),
    ["<M-Space>"] = cmp.mapping(
      cmp.mapping.complete {
        reason = cmp.ContextReason.Manual,
      },
      { "i", "c" }
    ),
    ["<C-n>"] = cmp.mapping(
      cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      { "i", "c" }
    ),
    ["<C-p>"] = cmp.mapping(
      cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      { "i", "c" }
    ),
    ["<c-y>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp", priority = 5, max_item_count = 5 },
    { name = "avante", priority = 2, max_item_count = 5 },
    { name = "luasnip", priority = 4, max_item_count = 3 },
    { name = "path", priority = 3, max_item_count = 3 },
    {
      name = "buffer",
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end,
      priority = 1,
      max_item_count = 5,
    },
  },
}

cmp.setup.cmdline(
  "/",
  { sources = { { name = "buffer", max_item_count = 10 } } }
)

cmp.setup.cmdline(":", {
  sources = cmp.config.sources {
    { name = "path", max_item_count = 20 },
    { name = "cmdline", max_item_count = 20 },
  },
})
