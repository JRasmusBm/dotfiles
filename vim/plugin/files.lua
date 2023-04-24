local commands = {
  "Remove",
  "Unlink",
  "Delete",
  "Copy",
  "Duplicate",
  "Move",
  "Rename",
  "Chmod",
  "Mkdir",
  "Cfind",
  "Lfind",
  "Clocate",
  "Llocate",
  "SudoEdit",
  "SudoWrite",
  "Wall",
  "W",
}

for _, command in ipairs(commands) do
  vim.api.nvim_create_user_command(command, function(options)
    require("jrasmusbm.utils").ensure_setup "vim-eunuch"

    require("jrasmusbm.utils.commands").run(command, options)
  end, { nargs = "*", bang = true })
end
