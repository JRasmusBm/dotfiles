return {
  "Olical/vim-enmasse",
  lazy = true,
  keys = {
    "<leader>fi",
  },
  config = function()
    vim.keymap.set({ "n" }, "<leader>fi", function()
      vim.cmd [[ EnMasse ]]
    end, { noremap = true })
  end,
}
