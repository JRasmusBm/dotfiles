return {
  user_message_template = "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nWrite really good unit tests using best practices for the given language. {{language_instructions}} Only return the unit tests. Only return the code snippet and nothing else. ",
  callback_type = "code_popup",
  language_instructions = {
    cpp = "Use modern C++ syntax. Generate unit tests using the gtest framework.",
    java = "Generate unit tests using the junit framework.",
  },
}
