" File {{{
inoremap <buffer> <leader>ssf * { box-sizing: border-box }S
  \html, body {padding: 0;margin: 0; }
"}}}

" Rule {{{
inoremap <buffer> <leader>sr <++> {<++>}<++>:call bushels#backward_marker(3)
"}}}

" Argument {{{
inoremap <buffer> <leader>sa <++>: <++>;<++>:call bushels#backward_marker(3)
"}}}

" Width {{{
inoremap <buffer> <leader>sw width: <++>;<++>:call bushels#backward_marker(2)
"}}}

" Height {{{
inoremap <buffer> <leader>sh height: <++>;<++>:call bushels#backward_marker(2)
"}}}

" Min {{{
" Width {{{
inoremap <buffer> <leader>smw min-width: <++>;<++>:call bushels#backward_marker(2)
"}}}
" Height {{{
inoremap <buffer> <leader>smh min-height: <++>;<++>:call bushels#backward_marker(2)
"}}}
"}}}

" Background {{{
" Specify {{{
inoremap <buffer> <leader>sbg background:<++>;<++>:call bushels#backward_marker(2)
"}}}
"}}}

" Flex {{{
" Grow {{{
inoremap <buffer> <leader>sfg flex-grow:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Direction {{{
inoremap <buffer> <leader>sfd flex-direction:<++>;<++>:call bushels#backward_marker(2) 
"}}}
"}}}

" Color {{{
inoremap <buffer> <leader>sc color: <++>;<++>:call bushels#backward_marker(2)
"}}}

" Font {{{
" Size {{{
inoremap <buffer> <leader>sfs font-size:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Family {{{
inoremap <buffer> <leader>sff font-family:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Weight {{{
inoremap <buffer> <leader>sfw font-weight:<++>;<++>:call bushels#backward_marker(2) 
"}}}
"}}}
"
" Text {{{
" Decoration {{{
inoremap <buffer> <leader>std text-decoration: <++>;<++>:call bushels#backward_marker(2) 
"}}}
" Align {{{
inoremap <buffer> <leader>sta text-align: <++>;<++>:call bushels#backward_marker(2) 
"}}}
"}}}

" Justify {{{
" Self {{{
inoremap <buffer> <leader>sjs justify-self:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Content {{{
inoremap <buffer> <leader>sjc justify-content:<++>;<++>:call bushels#backward_marker(2) 
"}}}
"}}}

" Align {{{
" Items {{{
inoremap <buffer> <leader>sai align-items:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Self {{{
inoremap <buffer> <leader>sas align-self:<++>;<++>:call bushels#backward_marker(2) 
"}}}
"}}}

" Border {{{
" Radius {{{
inoremap <buffer> <leader>sbr border-radius:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Specify {{{
inoremap <buffer> <leader>sbo border:<++>;<++>:call bushels#backward_marker(2) 
"}}}
"}}}

" Position {{{
" Specify {{{
inoremap <buffer> <leader>spo position:<++>;<++>:call bushels#backward_marker(2)
"}}}
"}}}

" Display{{{
" Block{{{
inoremap <buffer> <leader>sdb display: block;<++>:call bushels#backward_marker(1) 
"}}}
" Specify {{{
inoremap <buffer> <leader>sdd display: <++>;<++>:call bushels#backward_marker(2) 
"}}}
" Flex{{{
inoremap <buffer> <leader>sdf display: flex;<++>:call bushels#backward_marker(1) 
"}}}
" Grid{{{
inoremap <buffer> <leader>sdg display: grid;<++>:call bushels#backward_marker(1) 
"}}}
"}}}

" Padding {{{
" Specify {{{
inoremap <buffer> <leader>spd padding:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Top {{{
inoremap <buffer> <leader>spt padding-top:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Right {{{
inoremap <buffer> <leader>spr padding-right:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Left {{{
inoremap <buffer> <leader>spl padding-left:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Bottom {{{
inoremap <buffer> <leader>spb padding-bottom:<++>;<++>:call bushels#backward_marker(2) 
"}}}
"}}}

" Grid {{{
" Template Columns {{{
inoremap <buffer> <leader>stc grid-template-columns: <++>;<++>:call bushels#backward_marker(2) 
"}}}
" Template Rows {{{
inoremap <buffer> <leader>str grid-template-rows: <++>;<++>:call bushels#backward_marker(2) 
"}}}
" Row {{{
inoremap <buffer> <leader>sgr grid-row: <++>;<++> :call bushels#backward_marker(2) 
"}}}
" Column {{{
inoremap <buffer> <leader>sgc grid-column: <++>;<++> :call bushels#backward_marker(2) 
"}}}
" Dense{{{
inoremap <buffer> <leader>sgd grid-auto-flow: dense;<++> :call bushels#backward_marker(1)
"}}}
" Gap {{{
inoremap <buffer> <leader>sgg grid-gap: <++>;<++>:call bushels#backward_marker(2) 
"}}}
" Auto Rows {{{
inoremap <buffer> <leader>sar grid-auto-rows: <++>;<++> :call bushels#backward_marker(2) 
"}}}
"}}}

" Overflow {{{
" Hidden {{{
inoremap <buffer> <leader>soh overflow: hidden;<++> :call bushels#backward_marker(1)
"}}}
"}}}

" Media {{{
" Query {{{
inoremap <buffer> <leader>smq @media (<++>) {<++>}<++>:call bushels#backward_marker(3) 
"}}}
"}}}

" Z-Index {{{
inoremap <buffer> <leader>szi z-index:<++>;<++>:call bushels#backward_marker(2) 
"}}}

" Cursor {{{
inoremap <buffer> <leader>scu cursor:<++>;<++>:call bushels#backward_marker(2)
"}}}

" Opacity {{{
inoremap <buffer> <leader>sop opacity: <++>;<++> :call bushels#backward_marker(2) 
"}}}

" Box Shadow {{{
inoremap <buffer> <leader>sbs box-shadow: <++>;
      \<++>:call bushels#backward_marker(2)
" }}}

" Margin {{{
" Default{{{
inoremap <buffer> <leader>smg margin:;<++>:call bushels#backward_marker(2) 
"}}}
" Top{{{
inoremap <buffer> <leader>smt margin-top:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Right{{{
inoremap <buffer> <leader>smr margin-right:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Left{{{
inoremap <buffer> <leader>sml margin-left:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" Bottom{{{
inoremap <buffer> <leader>smb margin-bottom:<++>;<++>:call bushels#backward_marker(2) 
"}}}
" }}}
