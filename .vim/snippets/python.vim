"Function Definition
inoremap <buffer> ;fd <++>Odef <++>:<++>:call BackwardMarker(2)
"Class Definition
inoremap <buffer> ;cd <++>Oclass <++>:<++>:call BackwardMarker(2)
"Print
inoremap <buffer> ;pr <++>Oprint(<++>):call BackwardMarker(1)
"Dunder Declaration
inoremap <buffer> ;dd <++>Odef __<++>__(self, <++>):<++>:call BackwardMarker(3)
