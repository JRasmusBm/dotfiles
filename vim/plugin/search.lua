vim.g.LoupeCaseSettingsAlways = 1

vim.keymap.set({ "n" }, "gs", ':%s/<c-r>=expand("<cword>")<cr>/')

local loupe_handler = function(cmd)
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

vim.keymap.set({ "n" }, "<Leader> fc", "<cmd>Cheat<CR>", { noremap = true })

vim.keymap.set({ "n" }, "<localleader>fd", function()
  require("jrasmusbm.utils").ensure_setup "vcs-jump"
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump diff "
end, {})

vim.keymap.set({ "n" }, "<localleader>fg", function()
  require("jrasmusbm.utils").ensure_setup "vcs-jump"
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump grep "
end, {})

vim.keymap.set({ "n" }, "<localleader>fm", function()
  require("jrasmusbm.utils").ensure_setup "vcs-jump"
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump merge "
end, {})
