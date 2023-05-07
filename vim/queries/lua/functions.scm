(assignment_statement
  (variable_list 
      name: (identifier) @function.name
    )
  (expression_list
    value: (function_definition)
  )
)

(assignment_statement
  (variable_list 
      name: (dot_index_expression
        field: (identifier) @function.name
      )
  )
  (expression_list
    value: (function_definition)
  )
)
