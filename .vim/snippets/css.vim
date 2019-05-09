inoremap <buffer> ;sr <++> {<++>}<++>:call BackwardMarker(3)
inoremap <buffer> ;sa <++>: <++>;<++>:call BackwardMarker(3)

inoremap <buffer> ;sw width: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> ;sh height: <++>;<++>:call BackwardMarker(2)

inoremap <buffer> ;sfg flex-grow:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sfd flex-direction:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sta text-align: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sts font-size:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sjs justify-self:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sjc justify-content:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sai align-items:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sbr border-radius:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sdb display: block;<++>:call BackwardMarker(1) 
inoremap <buffer> ;sdf display: flex;<++>:call BackwardMarker(1) 

inoremap <buffer> ;spd padding:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;spt padding-top:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;spr padding-right:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;spl padding-left:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;spb padding-bottom:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;smd margin:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;smt margin-top:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;smr margin-right:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sml margin-left:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;smb margin-bottom:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;stc grid-template-columns: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;str grid-template-columns: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sgr grid-row: <++>;<++> :call BackwardMarker(2) 
inoremap <buffer> ;sgc grid-column: <++>;<++> :call BackwardMarker(2) 
inoremap <buffer> ;sfd grid-auto-flow: dense;<++> :call BackwardMarker(1)

inoremap <buffer> ;soh overflow: hidden;<++> :call BackwardMarker(1)
