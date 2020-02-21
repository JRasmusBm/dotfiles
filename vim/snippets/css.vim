" File {{{
inoremap <buffer> <leader>ssf * { box-sizing: border-box }S
  \html, body {padding: 0;margin: 0; }
"}}}

" Rule {{{
inoremap <buffer> <leader>sr <++> {<++>}<++>:call BackwardMarker(3)
"}}}

" Argument {{{
inoremap <buffer> <leader>sa <++>: <++>;<++>:call BackwardMarker(3)
"}}}

" Width {{{
inoremap <buffer> <leader>sw width: <++>;<++>:call BackwardMarker(2)
"}}}

" Height {{{
inoremap <buffer> <leader>sh height: <++>;<++>:call BackwardMarker(2)
"}}}

" Min {{{
" Width {{{
inoremap <buffer> <leader>smw min-width: <++>;<++>:call BackwardMarker(2)
"}}}
" Height {{{
inoremap <buffer> <leader>smh min-height: <++>;<++>:call BackwardMarker(2)
"}}}
"}}}

" Background {{{
" Specify {{{
inoremap <buffer> <leader>sbg background:<++>;<++>:call BackwardMarker(2)
"}}}
"}}}

" Flex {{{
" Grow {{{
inoremap <buffer> <leader>sfg flex-grow:<++>;<++>:call BackwardMarker(2) 
"}}}
" Direction {{{
inoremap <buffer> <leader>sfd flex-direction:<++>;<++>:call BackwardMarker(2) 
"}}}
"}}}

" Color {{{
inoremap <buffer> <leader>sc color: <++>;<++>:call BackwardMarker(2)
"}}}

" Font {{{
" Size {{{
inoremap <buffer> <leader>sfs font-size:<++>;<++>:call BackwardMarker(2) 
"}}}
" Family {{{
inoremap <buffer> <leader>sff font-family:<++>;<++>:call BackwardMarker(2) 
"}}}
" Weight {{{
inoremap <buffer> <leader>sfw font-weight:<++>;<++>:call BackwardMarker(2) 
"}}}
"}}}
"
" Text {{{
" Decoration {{{
inoremap <buffer> <leader>std text-decoration: <++>;<++>:call BackwardMarker(2) 
"}}}
" Align {{{
inoremap <buffer> <leader>sta text-align: <++>;<++>:call BackwardMarker(2) 
"}}}
"}}}

" Justify {{{
" Self {{{
inoremap <buffer> <leader>sjs justify-self:<++>;<++>:call BackwardMarker(2) 
"}}}
" Content {{{
inoremap <buffer> <leader>sjc justify-content:<++>;<++>:call BackwardMarker(2) 
"}}}
"}}}

" Align {{{
" Items {{{
inoremap <buffer> <leader>sai align-items:<++>;<++>:call BackwardMarker(2) 
"}}}
" Self {{{
inoremap <buffer> <leader>sas align-self:<++>;<++>:call BackwardMarker(2) 
"}}}
"}}}

" Border {{{
" Radius {{{
inoremap <buffer> <leader>sbr border-radius:<++>;<++>:call BackwardMarker(2) 
"}}}
" Specify {{{
inoremap <buffer> <leader>sbo border:<++>;<++>:call BackwardMarker(2) 
"}}}
"}}}

" Position {{{
" Specify {{{
inoremap <buffer> <leader>spo position:<++>;<++>:call BackwardMarker(2)
"}}}
"}}}

" Display{{{
" Block{{{
inoremap <buffer> <leader>sdb display: block;<++>:call BackwardMarker(1) 
"}}}
" Specify {{{
inoremap <buffer> <leader>sdd display: <++>;<++>:call BackwardMarker(2) 
"}}}
" Flex{{{
inoremap <buffer> <leader>sdf display: flex;<++>:call BackwardMarker(1) 
"}}}
" Grid{{{
inoremap <buffer> <leader>sdg display: grid;<++>:call BackwardMarker(1) 
"}}}
"}}}

" Padding {{{
" Specify {{{
inoremap <buffer> <leader>spd padding:<++>;<++>:call BackwardMarker(2) 
"}}}
" Top {{{
inoremap <buffer> <leader>spt padding-top:<++>;<++>:call BackwardMarker(2) 
"}}}
" Right {{{
inoremap <buffer> <leader>spr padding-right:<++>;<++>:call BackwardMarker(2) 
"}}}
" Left {{{
inoremap <buffer> <leader>spl padding-left:<++>;<++>:call BackwardMarker(2) 
"}}}
" Bottom {{{
inoremap <buffer> <leader>spb padding-bottom:<++>;<++>:call BackwardMarker(2) 
"}}}
"}}}

" Grid {{{
" Template Columns {{{
inoremap <buffer> <leader>stc grid-template-columns: <++>;<++>:call BackwardMarker(2) 
"}}}
" Template Rows {{{
inoremap <buffer> <leader>str grid-template-rows: <++>;<++>:call BackwardMarker(2) 
"}}}
" Row {{{
inoremap <buffer> <leader>sgr grid-row: <++>;<++> :call BackwardMarker(2) 
"}}}
" Column {{{
inoremap <buffer> <leader>sgc grid-column: <++>;<++> :call BackwardMarker(2) 
"}}}
" Dense{{{
inoremap <buffer> <leader>sgd grid-auto-flow: dense;<++> :call BackwardMarker(1)
"}}}
" Gap {{{
inoremap <buffer> <leader>sgg grid-gap: <++>;<++>:call BackwardMarker(2) 
"}}}
" Auto Rows {{{
inoremap <buffer> <leader>sar grid-auto-rows: <++>;<++> :call BackwardMarker(2) 
"}}}
"}}}

" Overflow {{{
" Hidden {{{
inoremap <buffer> <leader>soh overflow: hidden;<++> :call BackwardMarker(1)
"}}}
"}}}

" Media {{{
" Query {{{
inoremap <buffer> <leader>smq @media (<++>) {<++>}<++>:call BackwardMarker(3) 
"}}}
"}}}

" Z-Index {{{
inoremap <buffer> <leader>szi z-index:<++>;<++>:call BackwardMarker(2) 
"}}}

" Cursor {{{
inoremap <buffer> <leader>scu cursor:<++>;<++>:call BackwardMarker(2)
"}}}

" Opacity {{{
inoremap <buffer> <leader>sop opacity: <++>;<++> :call BackwardMarker(2) 
"}}}

" Margin {{{
" Default{{{
inoremap <buffer> <leader>smg margin:<++>;<++>:call BackwardMarker(2) 
"}}}
" Top{{{
inoremap <buffer> <leader>smt margin-top:<++>;<++>:call BackwardMarker(2) 
"}}}
" Right{{{
inoremap <buffer> <leader>smr margin-right:<++>;<++>:call BackwardMarker(2) 
"}}}
" Left{{{
inoremap <buffer> <leader>sml margin-left:<++>;<++>:call BackwardMarker(2) 
"}}}
" Bottom{{{
inoremap <buffer> <leader>smb margin-bottom:<++>;<++>:call BackwardMarker(2) 
"}}}
" }}}
