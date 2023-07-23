return {
  user_message_template = "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nOptimize this code. {{language_instructions}} Only return the code snippet and nothing else.",
  language_instructions = {
    cpp = "Use modern C++.",
  },
}
