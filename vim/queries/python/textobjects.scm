; Argument {{{
; Inner {{{

[
  (argument_list
    (_) @argument.inner
  )
  (parameters
    (_) @argument.inner
  )
  (dictionary
    (_) @argument.inner
  )
  (list
    (_) @argument.inner
  )
  (tuple
    (_) @argument.inner
  )
  (pattern_list
    (_) @argument.inner
  )
]


; }}}
; }}}

[
    (import_statement)
    (import_from_statement)
    (expression_statement)
    (return_statement)
    (if_statement)
    (raise_statement)
    (function_definition)
] @statement.outer
