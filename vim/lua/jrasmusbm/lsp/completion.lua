local M = {}

M.setup = vim.schedule_wrap(function()
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      ["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ["<C-e>"] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
      ["<CR>"] = cmp.mapping.confirm({select = true}),
    },
    sources = cmp.config.sources({
      {name = "nvim_lsp"},
      {
        name = "buffer",
        get_bufnrs = function() return vim.api.nvim_list_bufs() end,
      },
      {name = "path"},
    }),
  })

  cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})

  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      {name = "path"},
      {name = "cmdline"},
    }),
  })
end)

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").update_capabilities(M.capabilities)

return M
