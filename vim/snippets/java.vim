inoremap <buffer> ;pk package <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;id import <++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;cd public class <++> {<++>}<<A<++>:call BackwardMarker(3)
inoremap <buffer> ;hb /**<++>/<++>:call BackwardMarker(2) 
inoremap <buffer> ;hp @param <++><++>:call BackwardMarker(2)

inoremap <buffer> ;fd <++> <++>(<++>) {<++>}<++>:call BackwardMarker(5)
