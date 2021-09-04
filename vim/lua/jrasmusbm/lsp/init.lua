local on_attach = require("jrasmusbm.lsp.attach").on_attach

require("jrasmusbm.lsp.completion").setup {}

local filetype_path = require("plenary.path"):new(vim.fn.getenv("DOTFILES")) /
                        "vim" / "lua" / "jrasmusbm" / "lsp" / "filetypes"

require("jrasmusbm.lsp.efm").setup {on_attach = on_attach}

require("plenary.job"):new({
  command = "ls",
  cwd = filetype_path.filename,
  on_exit = vim.schedule_wrap(function(j)
    for _, file in ipairs(j:result()) do
      local filetype = vim.split(file, ".", true)[1]
      require("jrasmusbm.lsp.filetypes." .. filetype).setup {
        on_attach = on_attach,
      }
    end
  end),
}):start()
