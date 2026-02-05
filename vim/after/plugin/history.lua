local shada_path = vim.fn.expand("$HOME/.config/nvim/shada")

vim.opt.shada = require("jrasmusbm.utils.options").list {
  "'0",
  "<0",
  "f0",
  "n" .. shada_path,
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local stale_files = vim.fn.glob(shada_path .. ".tmp.*", false, true)
    for _, file in ipairs(stale_files) do
      local age_seconds = os.time() - vim.fn.getftime(file)
      if age_seconds > 3600 then
        vim.fn.delete(file)
      end
    end
  end,
})
