; Test {{{
; Case {{{
(
  (call_expression 
    function: (identifier) @function_name
  )
  (#match? @function_name "^(it|test)$")
) @test.case.outer
; }}}
; Suite {{{
(
  (call_expression 
    function: (identifier) @function_name
  )
  (#match? @function_name "^(describe)$")
) @test.suite.outer
; }}}
; }}}

; Statement {{{
[
  (break_statement)
  (continue_statement)
  (debugger_statement)
  (declaration)
  (do_statement)
  (empty_statement)
  (export_statement)
  (expression_statement)
  (for_in_statement)
  (for_statement)
  (if_statement)
  (import_statement)
  (labeled_statement)
  (return_statement)
  (statement_block)
  (switch_statement)
  (throw_statement)
  (try_statement)
  (while_statement)
  (with_statement)
  (expression_statement)
  (lexical_declaration)
  (if_statement)
] @statement.outer
; }}}

; Argument {{{
; Inner {{{
[
  (arguments 
    (_) @argument.inner
  )
  (object
    (_) @argument.inner
  )
  (array_pattern
    (_) @argument.inner
  )
  (object_pattern
    (_) @argument.inner
  )
  (array
    (_) @argument.inner
  )
  (formal_parameters
    (_) @argument.inner
  )
]
; }}}
; }}}
