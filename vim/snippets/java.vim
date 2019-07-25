inoremap <buffer> <leader>pk package <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>id import <++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>cd public class <++> {<++>}<<A<++>:call BackwardMarker(3)
inoremap <buffer> <leader>hb /**<++>/<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>hp @param <++><++>:call BackwardMarker(2)

inoremap <buffer> <leader>fd <++> <++>(<++>) {<++>}<++>:call BackwardMarker(5)
