vim.keymap.set({"n"},
  "<leader>mf",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.mark").add_file()
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>mm",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").toggle_quick_menu()
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>1",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(1)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>2",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(2)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>3",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(3)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>4",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(4)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>5",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(5)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>6",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(6)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>7",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(7)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>8",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(8)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>9",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(9)
  end

  ,
  { noremap = true }
)
vim.keymap.set({"n"},
  "<leader>0",
  function ()
    require"jrasmusbm.harpoon".ensure_setup()
    require("harpoon.ui").nav_file(10)
  end

  ,
  { noremap = true }
)
