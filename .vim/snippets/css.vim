inoremap <buffer> ;ssf * { box-sizing: border-box }S
  \html, body {padding: 0;margin: 0; }
inoremap <buffer> ;sr <++> {<++>}<++>:call BackwardMarker(3)
inoremap <buffer> ;sa <++>: <++>;<++>:call BackwardMarker(3)

inoremap <buffer> ;sw width: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> ;smw min-width: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> ;sh height: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> ;smh min-height: <++>;<++>:call BackwardMarker(2)

inoremap <buffer> ;sbg background:<++>;<++>:call BackwardMarker(2)

inoremap <buffer> ;sfg flex-grow:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sfd flex-direction:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sc color: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> ;std text-decoration: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sta text-align: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sfs font-size:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sff font-family:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sfw font-weight:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sjs justify-self:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sjc justify-content:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sai align-items:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sas align-self:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;sbr border-radius:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sbo border:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> ;spo position:<++>;<++>:call BackwardMarker(2)

inoremap <buffer> ;sdb display: block;<++>:call BackwardMarker(1) 
inoremap <buffer> ;sdf display: flex;<++>:call BackwardMarker(1) 
inoremap <buffer> ;sdg display: grid;<++>:call BackwardMarker(1) 

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
inoremap <buffer> ;str grid-template-rows: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sgr grid-row: <++>;<++> :call BackwardMarker(2) 
inoremap <buffer> ;sgc grid-column: <++>;<++> :call BackwardMarker(2) 
inoremap <buffer> ;sgd grid-auto-flow: dense;<++> :call BackwardMarker(1)
inoremap <buffer> ;sgg grid-gap: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> ;sar grid-auto-rows: <++>;<++> :call BackwardMarker(2) 

inoremap <buffer> ;soh overflow: hidden;<++> :call BackwardMarker(1)
