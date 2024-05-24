require("jrasmusbm.statusline").setup()

local update_highlights = function()
  vim.opt.background = require("jrasmusbm.theme").get_current_theme()

  require("jrasmusbm.colors").colorscheme()
  require("jrasmusbm.colors").fold_highlights()
  require("jrasmusbm.colors").error_highlights()
  require("jrasmusbm.colors").search_highlights()
  require("jrasmusbm.colors").spelling_highlights()
  require("jrasmusbm.colors").diagnostic_highlights()
  require("jrasmusbm.colors").custom_markers()
  require("jrasmusbm.colors").ruler_highlights()
  require("jrasmusbm.colors").illuminate_highlights()
  require("jrasmusbm.colors").dap_highlights()
  require("colorizer").setup()
end

update_highlights()

local jrb_theme_augroup =
  vim.api.nvim_create_augroup("jrb_theme", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  group = jrb_theme_augroup,
  pattern = { "*" },
  callback = function()
    update_highlights()
  end,
})
