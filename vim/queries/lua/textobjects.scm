(function_definition
  body: (block) @function.inner
) @function.outer

(parameters
  (_) @argument.inner
)

(table_constructor
  (_) @argument.inner
)

(arguments
  (_) @argument.inner
)

[
 (variable_declaration)
 (function_declaration)
 (assignment_statement)
 (return_statement)
 (for_statement)
 (if_statement)
 (function_call)
] @statement.outer
