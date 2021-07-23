(
  (call_expression 
    function: (identifier) @function_name
  )
  (#match? @function_name "^(it|test)$")
) @test.case.outer

(
  (call_expression 
    function: (identifier) @function_name
  )
  (#match? @function_name "^(describe)$")
) @test.suite.outer

[
  (expression_statement)
  (lexical_declaration)
] @statement.outer
