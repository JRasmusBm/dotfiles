(expression_statement
  (call
    function: (attribute
      attribute: (identifier) @_attribute (#eq? @_attribute "execute_sql")
    )
    arguments: (argument_list
      (string) @sql
    ) 
  )
)
