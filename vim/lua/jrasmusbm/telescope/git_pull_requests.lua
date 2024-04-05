local M = {}

local utils = require "telescope.utils"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local previewers = require "telescope.previewers"

local separator = ' + ";;;" + '
M.git_pull_requests = function()
  local results, res, stderr = utils.get_os_command_output {
    "gh",
    "pr",
    "list",
    "--json",
    "number,author,reviewDecision,isDraft,state,title,headRefName,createdAt",
    "-q",
    ". | sort_by(.created_at) | .[] |"
    .. '(.createdAt | fromdateiso8601 | strftime("%b %m %H:%M"))'
    .. separator
    .. "(.number | tostring)"
    .. separator
    .. ".author.login"
    .. separator
    .. '(if .reviewDecision != "" then .reviewDecision elif .isDraft then "DRAFT" else "OPEN" end)'
    .. separator
    .. ".title",
    "-L",
    "10000",
  }

  pickers
      .new({}, {
        prompt_title = "Git Pull Requests",
        finder = finders.new_table {
          results = results,
          entry_maker = function(line)
            local raw_line_parts = vim.split(line, ";;;")
            local pull_request_entry = {
              created_at = raw_line_parts[1],
              number = raw_line_parts[2],
              author_login = raw_line_parts[3],
              status = raw_line_parts[4],
              title = raw_line_parts[5],
            }

            local author_login_short =
                string.sub(pull_request_entry.author_login, 1, 8)
            local status_short = string.sub(pull_request_entry.status, 1, 8)

            return {
              value = line,
              ordinal = line,
              display = ""
                  .. pull_request_entry.created_at
                  .. " "
                  .. author_login_short
                  .. string.rep(" ", 9 - #author_login_short)
                  .. status_short
                  .. string.rep(" ", 9 - #status_short)
                  .. pull_request_entry.number
                  .. " "
                  .. pull_request_entry.title,
              number = pull_request_entry.number,
              title = pull_request_entry.title,
            }
          end,
        },
        previewer = previewers.new_termopen_previewer {
          title = "Issue Preview",
          get_command = function(entry)
            return { "gh", "pr", "view", entry.number }
          end,
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
          local switch = function()
            local pull_request_entry = action_state.get_selected_entry()

            actions.close(prompt_bufnr)
            vim.api.nvim_command("G pr " .. pull_request_entry.number)
          end

          local open_in_browser = function()
            local pull_request_entry = action_state.get_selected_entry()

            actions.close(prompt_bufnr)
            vim.api.nvim_command(
              "!gh pr view --web " .. pull_request_entry.number
            )
          end

          map("i", "<C-b>", open_in_browser)
          map("n", "<C-b>", open_in_browser)
          actions.select_default:replace(switch)
          return true
        end,
      })
      :find()
end

return M
