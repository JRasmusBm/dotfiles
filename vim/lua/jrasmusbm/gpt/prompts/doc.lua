return {
  user_message_template = "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nWrite really good documentation using best practices for the given language. Attention paid to documenting parameters, return types, any exceptions or errors. {{language_instructions}} Only return the code snippet and nothing else.",
  language_instructions = {
    cpp = "Use doxygen style comments for functions.",
    java = "Use JavaDoc style comments for functions.",
  },
}
