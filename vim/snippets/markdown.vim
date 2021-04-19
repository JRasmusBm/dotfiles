" Bullet {{{
" List {{{
inoremap <buffer> <leader>bl - 	<++>s<++><<:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Node {{{
inoremap <buffer> <leader>bn ?^ *- :nohyy0}PWc$
"}}}
"}}}

" Numbered {{{
" List {{{
inoremap <buffer> <leader>nl 1.	<++>s<++><<:call jrasmusbm#snippets#backward_marker(2)
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
inoremap <buffer> <leader>fp ---path: "<++>"date: ":put =strftime(\"%Y-%m-%d\")kJxA"title: "<++>"summary: "<++>"---<++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Date {{{
inoremap <buffer> <leader>fd :put =strftime(\"%Y-%m-%d\")C"""Idate: A
" }}}
" Attendees {{{
inoremap <buffer> <leader>fa oattendees: "<++>":call jrasmusbm#snippets#backward_marker(1)
" }}}
" Note {{{
inoremap <buffer> <leader>fn ---
            \title: "<++>"
            \---
            \# <++>
            \## Tags
            \- <++>0C
            \## <++>
            \<++>:call jrasmusbm#snippets#backward_marker(5)
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
    \<++>:call jrasmusbm#snippets#backward_marker(8)
" }}}
"}}}

" Link {{{
inoremap <buffer> <leader>li [<++>](<++>)<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}

" Image {{{
inoremap <buffer> <leader>im ![<++>](<++>)<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}

" Reference {{{
inoremap <buffer> <leader>rr [<++>]: <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}

" Emphasize {{{
inoremap <buffer> <leader>em *<++>*<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}

" Boldface {{{
inoremap <buffer> <leader>bo **<++>**<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}

" Strikethrough {{{
inoremap <buffer> <leader>st ~~<++>~~<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}

" Code {{{
" Inline {{{
inoremap <buffer> <leader>ci `<++>`<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Block {{{
inoremap <buffer> <leader>cb ```<++><++>```<++>:call jrasmusbm#snippets#backward_marker(3)A
"}}}
"}}}

" Table {{{
" T1 {{{
inoremap <buffer> <leader>t1 \| <++> \|\|------\|\| <++> \|:call jrasmusbm#snippets#backward_marker(2)
"}}}
" T2 {{{
inoremap <buffer> <leader>t2 \| <++> \| <++> \|\|------\|------\|\| <++> \| <++> \|:call jrasmusbm#snippets#backward_marker(4)
"}}}
" T3 {{{
inoremap <buffer> <leader>t3 \| <++> \| <++> \| <++> \|\|------\|------\|------\|\| <++> \| <++> \| <++> \|:call jrasmusbm#snippets#backward_marker(6)
"}}}
" T4 {{{
inoremap <buffer> <leader>t4 \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \|:call jrasmusbm#snippets#backward_marker(8)
"}}}
" T5 {{{
inoremap <buffer> <leader>t5 \| <++> \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \| <++> \|:call jrasmusbm#snippets#backward_marker(10)
"}}}
" T6 {{{
inoremap <leader>t6 \| <++> \| <++> \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \| <++> \| <++> \|:call jrasmusbm#snippets#backward_marker(12)
"}}}
"}}}

" Quote {{{
inoremap <buffer> <leader>qu I<++>OO>
"}}}

