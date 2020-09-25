" Bullet {{{
" List {{{
inoremap <buffer> <leader>bl - 	<++>s<++><<:call BackwardMarker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>bn ?^ *- :nohyy0}PWc$
"}}}
"}}}

" Numbered {{{
" List {{{
inoremap <buffer> <leader>nl 1.	<++>s<++><<:call BackwardMarker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>nn ?^ *[0-9]:nohyy0}PWc$
"}}}
"}}}

" Header {{{
" H1 {{{
inoremap <buffer> <leader>h1 I<++>OO# $a
"}}}
" H2 {{{
inoremap <buffer> <leader>h2 I<++>OO## $a
"}}}
" H3 {{{
inoremap <buffer> <leader>h3 I<++>OO### $a
"}}}
" H4 {{{
inoremap <buffer> <leader>h4 I<++>OO#### $a
"}}}
" H5 {{{
inoremap <buffer> <leader>h5 I<++>OO##### $a
"}}}
"}}}

" Frontmatter {{{
" Lecture {{{
inoremap <buffer> <leader>fl <++>O> Date: :put =strftime(\"%Y-%m-%d\")kJA  o> Instructor:
"}}}
" Post {{{
inoremap <buffer> <leader>fp ---path: "<++>"date: ":put =strftime(\"%Y-%m-%d\")kJxA"title: "<++>"summary: "<++>"---<++>:call BackwardMarker(4)
"}}}
" Date {{{
inoremap <buffer> <leader>fd :put =strftime(\"%Y-%m-%d\")C"""Idate: A
" }}}
" Attendees {{{
inoremap <buffer> <leader>fa oattendees: "<++>":call BackwardMarker(1)
" }}}
" Note {{{
inoremap <buffer> <leader>fn ---
            \title: "<++>"
            \tags: "<++>"
            \---
            \<++>:call BackwardMarker(3)
            
"}}}
" CV {{{
inoremap <buffer> <leader>fc ---
    \Duration: <++>
    \Customer: <++>
    \Project: <++>
    \Industry: <++>
    \---
    \# Kundbeskrivning
    \<++>
    \# Projektbeskrivning
    \<++>
    \# Roller
    \## <++>
    \<++>:call BackwardMarker(8)
" }}}
"}}}

" Link {{{
inoremap <buffer> <leader>li [<++>](<++>)<++>:call BackwardMarker(3)
"}}}

" Image {{{
inoremap <buffer> <leader>im ![<++>](<++>)<++>:call BackwardMarker(3)
"}}}

" Reference {{{
inoremap <buffer> <leader>rr [<++>]: <++>:call BackwardMarker(2)
"}}}

" Emphasize {{{
inoremap <buffer> <leader>em *<++>*<++>:call BackwardMarker(2)
"}}}

" Boldface {{{
inoremap <buffer> <leader>bo **<++>**<++>:call BackwardMarker(2)
"}}}

" Strikethrough {{{
inoremap <buffer> <leader>st ~~<++>~~<++>:call BackwardMarker(2)
"}}}

" Code {{{
" Inline {{{
inoremap <buffer> <leader>ci `<++>`<++>:call BackwardMarker(2)
"}}}
" Block {{{
inoremap <buffer> <leader>cb ```<++><++>```<++>:call BackwardMarker(3)A
"}}}
"}}}

" Table {{{
" T1 {{{
inoremap <buffer> <leader>t1 \| <++> \|\|------\|\| <++> \|:call BackwardMarker(2)
"}}}
" T2 {{{
inoremap <buffer> <leader>t2 \| <++> \| <++> \|\|------\|------\|\| <++> \| <++> \|:call BackwardMarker(4)
"}}}
" T3 {{{
inoremap <buffer> <leader>t3 \| <++> \| <++> \| <++> \|\|------\|------\|------\|\| <++> \| <++> \| <++> \|:call BackwardMarker(6)
"}}}
" T4 {{{
inoremap <buffer> <leader>t4 \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \|:call BackwardMarker(8)
"}}}
" T5 {{{
inoremap <buffer> <leader>t5 \| <++> \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \| <++> \|:call BackwardMarker(10)
"}}}
" T6 {{{
inoremap <leader>t6 \| <++> \| <++> \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \| <++> \| <++> \|:call BackwardMarker(12)
"}}}
"}}}

" Quote {{{
inoremap <buffer> <leader>qu I<++>OO>
"}}}

