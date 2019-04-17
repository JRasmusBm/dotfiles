inoremap <buffer> ;fm :call ForwardMarker(<++>)<++>:call BackwardMarker(2)
inoremap <buffer> ;bm :call BackwardMarker(<++>)<++>:call BackwardMarker(2)
inoremap <buffer> ;fl " <++> {{{S<++>" }}}:call BackwardMarker(2) 
inoremap <buffer> ;sn inoremap <buffer> ;<++> <++>:call BackwardMarker(2)
inoremap <buffer> ;pl Plug '<++>/<++>':call BackwardMarker(2)
