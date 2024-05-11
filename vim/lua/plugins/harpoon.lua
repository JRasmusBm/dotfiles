return {
  "ThePrimeagen/harpoon",
  lazy = true,
  keys = {
    "<leader>mf",
    "<leader>mm",
    "<leader>1",
    "<leader>2",
    "<leader>3",
    "<leader>4",
    "<leader>5",
    "<leader>6",
    "<leader>7",
    "<leader>8",
    "<leader>9",
    "<leader>0",
  },
  config = function()
    require("harpoon").setup {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        mark_branch = true,
      },
    }
    require("jrasmusbm.harpoon").setup()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
