;; extends

; Template literals containing Handlebars block syntax
((template_string) @injection.content
  (#lua-match? @injection.content "{{[#/]")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "glimmer"))
