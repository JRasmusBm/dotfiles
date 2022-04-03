local M = {}

local file_names = require("plenary.path"):new(vim.fn.getenv "DOTFILES")
  / "vim"
  / "lua"
  / "jrasmusbm"
  / "lsp"
  / "efm"
  / "filetypes"

local lspconfig = require "lspconfig"

local setup_efm = vim.schedule_wrap(function(options)
  lspconfig.efm.setup {
    capabilities = options.capabilities,
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.publish_diagnostics = false

      local filetype = vim.fn.getbufvar(bufnr, "&ft")
      local file_config = options.languages[vim.split(filetype, ".", true)[1]]

      if file_config == nil then
        return
      end

      for _, v in ipairs(file_config) do
        if v.formatCommand then
          client.resolved_capabilities.document_formatting = true
        end

        if v.lintCommand then
          client.resolved_capabilities.publish_diagnostics = true
        end
      end

      options.on_attach(client, bufnr)
    end,
    cmd = { "efm-langserver" },
    filetypes = options.filetypes,
    settings = { rootMarkers = { ".git/" }, languages = options.languages },
  }
end)

M.setup = function(options)
  require("plenary.job")
    :new({
      command = "ls",
      cwd = file_names.filename,
      on_exit = function(j)
        local filetypes = {}
        local languages = {}
        for _, file_name in ipairs(j:result()) do
          local module_name = vim.split(file_name, ".", true)[1]
          local module = require("jrasmusbm.lsp.efm.filetypes." .. module_name)
          for _, filetype in ipairs(module.filetypes) do
            languages[filetype] = module.config
            table.insert(filetypes, filetype)
          end
        end

        setup_efm {
          languages = languages,
          filetypes = filetypes,
          on_attach = options.on_attach,
        }
      end,
    })
    :start()
end

return M
