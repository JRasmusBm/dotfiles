local M = {}

M.colorscheme = function()
  vim.g.gruvbox_material_palette = "material"
  vim.cmd.colorscheme "gruvbox-material"
  if require("jrasmusbm.theme").get_current_theme() == "light" then
    vim.api.nvim_set_hl(0, "Normal", {
      fg = "#442e08",
    })
  else
    vim.api.nvim_set_hl(0, "Normal", {
      fg = "#d4be98",
    })
  end

  vim.api.nvim_set_hl(0, "NonText", {})
end

M.custom_markers = function()
  vim.cmd [[

  match TODOMarker /TODO/
  match SnippetMarker /<++>/
  ]]

  vim.api.nvim_set_hl(0, "SnippetMarker", {
    fg = "yellow",
    bg = nil,
  })
  vim.api.nvim_set_hl(0, "TODOMarker", {
    fg = "#FF87AF",
    bg = nil,
  })
end

M.ruler_highlights = function()
  if require("jrasmusbm.theme").get_current_theme() == "light" then
    vim.api.nvim_set_hl(0, "CursorColumn", {
      bg = "#e0e090",
    })
    vim.api.nvim_set_hl(0, "CursorLine", {
      bg = "#e0e090",
    })
    vim.api.nvim_set_hl(0, "ColorColumn", {
      bg = "#c0a050",
    })
  else
    vim.api.nvim_set_hl(0, "CursorColumn", {
      bg = "#2a2a00",
    })
    vim.api.nvim_set_hl(0, "CursorLine", {
      bg = "#2a2a00",
    })
    vim.api.nvim_set_hl(0, "ColorColumn", {
      bg = "#301810",
    })
  end
end

M.illuminate_highlights = function()
  vim.api.nvim_set_hl(0, "LspReferenceText", {
    link = "CursorLine",
  })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", {
    link = "CursorLine",
  })
  vim.api.nvim_set_hl(0, "LspReferenceRead", {
    link = "CursorLine",
  })
  vim.api.nvim_set_hl(0, "illuminatedWord", {
    link = "CursorLine",
  })
end

M.dap_highlights = function()
  vim.api.nvim_set_hl(0, "debugPC", {
    fg = "#282828",
    bg = "#a9b665",
  })
  vim.fn.sign_define("DapBreakpoint", { text = "🔴" })
  vim.fn.sign_define("DapBreakpoint", { text = "🟡" })
  vim.fn.sign_define("DapBreakpoint", { text = "🐛" })
end

M.diagnostic_highlights = function()
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
    fg = "red",
  })
  vim.fn.sign_define(
    "DiagnosticSignError",
    { text = "✗", texthl = "DiagnosticSignError" }
  )
  vim.api.nvim_set_hl(0, "DiagnosticSignError", {
    fg = "red",
  })

  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {
    fg = "yellow",
  })
  vim.fn.sign_define(
    "DiagnosticSignWarn",
    { text = "⚠", texthl = "DiagnosticSignWarn" }
  )
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", {
    fg = "yellow",
  })

  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {
    fg = "teal",
  })
  vim.fn.sign_define(
    "DiagnosticSignInfo",
    { text = "⚠", texthl = "DiagnosticSignInfo" }
  )
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", {
    fg = "teal",
  })

  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", {
    fg = "teal",
  })
  vim.fn.sign_define(
    "DiagnosticSignHint",
    { text = "☼", texthl = "DiagnosticSignHint" }
  )
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", {
    fg = "teal",
  })
end

M.spelling_highlights = function()
  for _, name in ipairs { "SpellBad", "SpellCap", "SpellLocal", "SpellRare" } do
    vim.api.nvim_set_hl(0, name, {
      fg = "teal",
    })
  end
end

M.search_highlights = function()
  if require("jrasmusbm.theme").get_current_theme() == "light" then
    vim.api.nvim_set_hl(0, "Search", {
      fg = "#d0d030",
    })
  else
    vim.api.nvim_set_hl(0, "Search", {
      fg = "yellow",
    })
  end
end

M.error_highlights = function()
  vim.api.nvim_set_hl(0, "Error", {
    fg = "red",
  })
  vim.api.nvim_set_hl(0, "BadWhitespace", {
    bg = "darkred",
  })
end

M.fold_highlights = function()
  if require("jrasmusbm.theme").get_current_theme() == "light" then
    vim.api.nvim_set_hl(0, "Folded", {
      fg = "#906020",
    })
    vim.api.nvim_set_hl(0, "FoldColumn", {
      fg = "white",
      bg = "darkgrey",
    })
  else
    vim.api.nvim_set_hl(0, "Folded", {
      fg = "darkyellow",
    })
    vim.api.nvim_set_hl(0, "FoldColumn", {
      fg = "white",
      bg = "darkgrey",
    })
  end
end

return M
