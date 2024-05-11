local M = {}

local default_config = {
  model = "gpt-4",
  max_tokens = 4096,
  temperature = 0.8,
  number_of_choices = 1,
  system_message_template = "You are a {{language}} coding assistant.",
  user_message_template = "",
  callback_type = "replace_lines",
}

local load_prompts = function()
  local prompts_path = (
    require("plenary.path"):new(vim.fn.getenv "DOTFILES")
    / "vim"
    / "lua"
    / "jrasmusbm"
    / "gpt"
    / "prompts"
  )

  local prompt_files =
    require("plenary.scandir").scan_dir(prompts_path.filename, { depth = 1 })

  vim.g["codegpt_commands_defaults"] = {}
  local new_prompts = {}

  for _, file in ipairs(prompt_files) do
    local path_elements = vim.split(file, "/", { plain = "true" })
    local prompt =
      vim.split(path_elements[#path_elements], ".", { plain = "true" })[1]
    new_prompts[prompt] = vim.tbl_extend(
      "force",
      default_config,
      require("jrasmusbm.gpt.prompts." .. prompt)
    )
  end

  vim.g["codegpt_commands"] = new_prompts
end

M.setup = function()
  if os.getenv "OPENAI_API_KEY" ~= nil then
    vim.g["codegpt_openai_api_key"] = os.getenv "OPENAI_API_KEY"
  end
  vim.g["codegpt_chat_completions_url"] =
    "https://api.openai.com/v1/chat/completions"

  -- alternative provider
  vim.g["codegpt_openai_api_provider"] = "OpenAI"

  -- clears visual selection after completion
  vim.g["codegpt_clear_visual_selection"] = true

  vim.g["codegpt_hooks"] = {
    request_started = nil,
    request_finished = nil,
  }

  -- Border style to use for the popup
  vim.g["codegpt_popup_border"] = { style = "rounded" }

  -- Wraps the text on the popup window, deprecated in favor of codegpt_popup_window_options
  vim.g["codegpt_wrap_popup_text"] = true

  vim.g["codegpt_popup_window_options"] = {}

  -- set the filetype of a text popup is markdown
  vim.g["codegpt_text_popup_filetype"] = "markdown"

  -- Set the type of ui to use for the popup, options are "popup", "vertical" or "horizontal"
  vim.g["codegpt_popup_type"] = "popup"

  -- Set the height of the horizontal popup
  vim.g["codegpt_horizontal_popup_size"] = "20%"

  -- Set the width of the vertical popup
  vim.g["codegpt_vertical_popup_size"] = "20%"

  -- Popup commands
  vim.g["codegpt_ui_commands"] = {
    quit = "q",
    use_as_output = "<c-o>",
    use_as_input = "<c-i>",
  }

  load_prompts()
end

return M
