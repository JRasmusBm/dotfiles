vim.cmd [[
sign define DiagnosticErrorSign text=✗ texthl=DiagnosticError
sign define DiagnosticWarningSign text=⚠ texthl=DiagnosticWarning
sign define DiagnosticInformationSign text=i texthl=DiagnosticInformation
sign define DiagnosticHintSign text=※ texthl=DiagnosticHint

augroup LspLocationList
  autocmd User DiagnosticChanged lua vim.diagnostic.setloclist({ open=false })
augroup END
]]

local opts = { noremap = true, silent = true, buffer = 0 }

vim.keymap.set({ "n" }, "g?", vim.diagnostic.open_float, opts)

vim.keymap.set({ "n" }, "[v", function()
  vim.diagnostic.jump {
    count = -1,
    severity = { min = vim.diagnostic.severity.ERROR },
  }
end, opts)

vim.keymap.set({ "n" }, "]v", function()
  vim.diagnostic.jump {
    count = 1,
    severity = { min = vim.diagnostic.severity.ERROR },
  }
end, opts)

vim.keymap.set({ "n" }, "[V", function()
  vim.diagnostic.jump {
    count = -1,
    severity = { max = vim.diagnostic.severity.WARN },
  }
end, opts)

vim.keymap.set({ "n" }, "]V", function()
  vim.diagnostic.jump {
    count = 1,
    severity = { max = vim.diagnostic.severity.WARN },
  }
end, opts)
