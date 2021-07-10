local config = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local make_entry = require('telescope.make_entry')
local Path = require("plenary.path")
local os_sep = Path.path.sep

local filter = vim.tbl_filter
local flatten = vim.tbl_flatten

local M = {}

local escape_chars = function(string)
  return string.gsub(string,  "[%(|%)|\\|%[|%]|%-|%{%}|%?|%+|%*]", {
    ["\\"] = "\\\\", ["-"] = "\\-",
    ["("] = "\\(", [")"] = "\\)",
    ["["] = "\\[", ["]"] = "\\]",
    ["{"] = "\\{", ["}"] = "\\}",
    ["?"] = "\\?", ["+"] = "\\+",
    ["*"] = "\\*",
  })
end

M.live_grep = function (options_)
  local options = options_ or {}
  local vimgrep_arguments = options.vimgrep_arguments or config.vimgrep_arguments
  local search_dirs = options.search_dirs
  local grep_open_files = options.grep_open_files

  local filelist = {}

  if grep_open_files then
   local bufnrs = filter(function(b)
      if 1 ~= vim.fn.buflisted(b) then return false end
      return true
    end, vim.api.nvim_list_bufs())
    if not next(bufnrs) then return end

    local tele_path = require'telescope.path'
    for _, bufnr in ipairs(bufnrs) do
      local file = vim.api.nvim_buf_get_name(bufnr)
      table.insert(filelist, tele_path.make_relative(file, options.cwd))
    end
  elseif search_dirs then
    for i, path in ipairs(search_dirs) do
      search_dirs[i] = vim.fn.expand(path)
    end
  end

  local live_grepper = finders.new_job(function(prompt)
    -- TODO: Probably could add some options for smart case and whatever else rg offers.

    if not prompt or prompt == "" then
      return nil
    end

    prompt = options.use_regex and prompt or escape_chars(prompt)

    local search_list = {}

    if search_dirs then
      table.insert(search_list, search_dirs)
    elseif os_sep == '\\' then
      table.insert(search_list, '.')
    end

    if grep_open_files then
      search_list = filelist
    end

    return flatten { vimgrep_arguments, prompt, search_list }
  end,
  options.entry_maker or make_entry.gen_from_vimgrep(options),
  options.max_results,
  options.cwd
  )

  pickers.new(options, {
    prompt_title = 'Live Grep',
    finder = live_grepper,
    previewer = config.grep_previewer(options),
    sorter = config.generic_sorter(options),
  }):find()
end

return M
