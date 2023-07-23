return {
  user_message_template = "I have the following {{language}} code snippet: ```{{filetype}}\n{{text_selection}}```\nComplete the rest. Use best practices and write really good documentation. {{language_instructions}} Only return the code snippet and nothing else.",
  language_instructions = {
    cpp = "Use modern C++ features.",
    java = "Use modern Java syntax. Use var when applicable.",
  },
}
