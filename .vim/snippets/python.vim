"Function Definition
inoremap <buffer> ;fd def <++>(<++>):<++><++><<:call BackwardMarker(3)
inoremap <buffer> ;fa <++>, <++>:call BackwardMarker(2) 
"Class Definition
inoremap <buffer> ;cd class <++>:<++><++><<:call BackwardMarker(2)
"Print
inoremap <buffer> ;pr <++>Oprint(<++>):call BackwardMarker(1)
"Dunder Declaration
inoremap <buffer> ;pd <++>Odef __<++>__(self, <++>):<++>:call BackwardMarker(3)

inoremap <buffer> ;in from <++> import <++>:call BackwardMarker(2)
inoremap <buffer> ;im import 
