require("jrasmusbm.utils").ensure_setup("vim-gitgutter")
require("jrasmusbm.utils").ensure_setup("nvim-web-devicons")

vim.cmd [[
command! -nargs=? L silent call jrasmusbm#git#open_tree(<f-args>)

command! Gpa call jrasmusbm#git#push_all()
]]

vim.g.diffopt = require("jrasmusbm.utils.options").list {
  "filler",
  "context:3",
  "iwhiteall",
  "internal",
  "hiddenoff",
}
vim.g.fugitive_git_executable = "g"

vim.g.fugitive_gitlab_domains = {}

vim.api.nvim_create_user_command("G", function(options)
  require("jrasmusbm.utils").ensure_setup "vim-rhubarb"
  require("jrasmusbm.utils").ensure_setup "fugitive-gitlab.vim"
  require("jrasmusbm.utils").ensure_setup "vim-fugitive"

  vim.cmd("Git " .. options.args)
end, { nargs = "*" })

vim.api.nvim_create_user_command("GBrowse", function(options)
  require("jrasmusbm.utils").ensure_setup "vim-rhubarb"
  require("jrasmusbm.utils").ensure_setup "fugitive-gitlab.vim"
  require("jrasmusbm.utils").ensure_setup "vim-fugitive"

  if options.fargs[1] == "mv" then
   vim.cmd({command="GMove", args={options.fargs[2]}}) 
   return
  end

  if options.fargs[1] == "browse" then
    if options.bang then
   vim.cmd({command="GBrowse", args={options.fargs[2]}}) 
 else
   vim.cmd({command="GBrowse!", args={options.fargs[2]}}) 
      
    end

    
   return
  end

  


  if options.bang then
    vim.cmd("GBrowse! " .. options.args)
  else
    vim.cmd("GBrowse " .. options.args)
  end
end, { bang = true, nargs = "*" })

vim.keymap.set({ "n", "x" },"<leader>h", function ()
  require("jrasmusbm.git").open_github_link()
end

)

