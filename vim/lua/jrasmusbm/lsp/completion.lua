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
          reason = cmp.ContextReason.Auto,
        },
        { "i", "c" }
      ),
      ["<M-Space>"] = cmp.mapping(
        cmp.mapping.complete {
          reason = cmp.ContextReason.Manual,
        },
        { "i", "c" }
      ),
      ["<Enter>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
    },
    sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1 },
      {
        name = "buffer",
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
        priority = 2,
      },
      { name = "path", priority = 3 },
    },
  }

  cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

  cmp.setup.cmdline(":", {
    sources = cmp.config.sources { { name = "path" }, { name = "cmdline" } },
  })
end)

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").update_capabilities(M.capabilities)

return M
