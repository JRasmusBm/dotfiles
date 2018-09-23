"Function Definition
inoremap ;fd <++>Odef <++>:<++>:call BackwardMarker(2)
"Class Definition
inoremap ;cd <++>Oclass <++>:<++>:call BackwardMarker(2)
"Print
inoremap ;pr <++>Oprint(<++>):call BackwardMarker(1)
"Dunder Declaration
inoremap ;dd <++>Odef __<++>__(self, <++>):<++>:call BackwardMarker(3)
