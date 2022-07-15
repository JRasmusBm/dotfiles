local M = {}

M.setup = vim.schedule_wrap(function()
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
config  ={          reason = cmp.ContextReason.Auto,}
        },
        { "i", "c" }
      ),
      ["<M-Space>"] = cmp.mapping(
        cmp.mapping.complete {
          reason = cmp.ContextReason.Manual,
        },
        { "i", "c" }
      ),
      ["<C-n>"] = cmp.mapping.select_next_item(
        { behavior = cmp.SelectBehavior.Insert },
        { "i", "c" }
      ),
      ["<C-p>"] = cmp.mapping.select_prev_item(
        { behavior = cmp.SelectBehavior.Insert },
        { "i", "c" }
      ),
      ["<c-y>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
    },
    sources = cmp.config.sources {
      { name = "luasnip", priority = 1, max_item_count = 3 },
      { name = "nvim_lsp", priority = 2, max_item_count = 20 },
      {
        name = "buffer",
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
        priority = 3,
        max_item_count = 20,
      },
      { name = "path", priority = 4, max_item_count = 20 },
    },
  }

  cmp.setup.cmdline(
    "/",
    { sources = { { name = "buffer", max_item_count = 20 } } }
  )

  cmp.setup.cmdline(":", {
    sources = cmp.config.sources {
      { name = "path", max_item_count = 20 },
      { name = "cmdline", max_item_count = 20 },
    },
  })
end)

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").update_capabilities(M.capabilities)

return M
