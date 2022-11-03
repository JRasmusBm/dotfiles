    require("jrasmusbm.utils").ensure_setup "loupe"

local loupe_handler = function(cmd)
  vim.g.LoupeCaseSettingsAlways = 1

  return function()
    require("jrasmusbm.utils").ensure_setup "loupe"

    local handler = function()
      require("jrasmusbm.utils.mappings").feedkeys(
        "<Plug>("
          .. cmd
          .. ")"
          .. ':lua require("jrasmusbm.search").set_search_as_x()<CR>'
      )
    end

    vim.keymap.set({ "n" }, "*", handler, { silent = true })
    handler()
  end
end

vim.keymap.set({ "n" }, "*", loupe_handler "LoupeStar", { silent = true })
vim.keymap.set({ "n" }, "#", loupe_handler "LoupeOctothorpe", {
  silent = true,
})
