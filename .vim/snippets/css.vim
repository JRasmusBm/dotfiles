inoremap <buffer> <leader>ssf * { box-sizing: border-box }S
  \html, body {padding: 0;margin: 0; }
inoremap <buffer> <leader>sr <++> {<++>}<++>:call BackwardMarker(3)
inoremap <buffer> <leader>sa <++>: <++>;<++>:call BackwardMarker(3)

inoremap <buffer> <leader>sw width: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> <leader>smw min-width: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> <leader>sh height: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> <leader>smh min-height: <++>;<++>:call BackwardMarker(2)

inoremap <buffer> <leader>sbg background:<++>;<++>:call BackwardMarker(2)

inoremap <buffer> <leader>sfg flex-grow:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sfd flex-direction:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>sc color: <++>;<++>:call BackwardMarker(2)
inoremap <buffer> <leader>std text-decoration: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sta text-align: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sfs font-size:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sff font-family:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sfw font-weight:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>sjs justify-self:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sjc justify-content:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>sai align-items:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sas align-self:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>sbr border-radius:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sbo border:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>spo position:<++>;<++>:call BackwardMarker(2)

inoremap <buffer> <leader>sdb display: block;<++>:call BackwardMarker(1) 
inoremap <buffer> <leader>sdf display: flex;<++>:call BackwardMarker(1) 
inoremap <buffer> <leader>sdg display: grid;<++>:call BackwardMarker(1) 

inoremap <buffer> <leader>spd padding:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>spt padding-top:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>spr padding-right:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>spl padding-left:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>spb padding-bottom:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>smg margin:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>smt margin-top:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>smr margin-right:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sml margin-left:<++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>smb margin-bottom:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>stc grid-template-columns: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>str grid-template-rows: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sgr grid-row: <++>;<++> :call BackwardMarker(2) 
inoremap <buffer> <leader>sgc grid-column: <++>;<++> :call BackwardMarker(2) 
inoremap <buffer> <leader>sgd grid-auto-flow: dense;<++> :call BackwardMarker(1)
inoremap <buffer> <leader>sgg grid-gap: <++>;<++>:call BackwardMarker(2) 
inoremap <buffer> <leader>sar grid-auto-rows: <++>;<++> :call BackwardMarker(2) 

inoremap <buffer> <leader>soh overflow: hidden;<++> :call BackwardMarker(1)

inoremap <buffer> <leader>smq @media (<++>) {<++>}<++>:call BackwardMarker(3) 

inoremap <buffer> <leader>szi z-index:<++>;<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>scu cursor:<++>;<++>:call BackwardMarker(2)

inoremap <buffer> <leader>sop opacity: <++>;<++> :call BackwardMarker(2) 
