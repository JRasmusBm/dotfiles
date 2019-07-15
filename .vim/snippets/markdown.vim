inoremap <buffer> <leader>bl - 	<++><++><<$:call BackwardMarker(2)
inoremap <buffer> <leader>nl 1.	<++><++><<$:call BackwardMarker(2)
inoremap <buffer> <leader>nn ?^ *[0-9]:nohyy0}PWc$
inoremap <buffer> <leader>bn ?^ *- :nohyy0}PWc$
inoremap <buffer> <leader>h1 I<++>OO# $a
inoremap <buffer> <leader>h2 I<++>OO## $a
inoremap <buffer> <leader>h3 I<++>OO### $a
inoremap <buffer> <leader>h4 I<++>OO#### $a
inoremap <buffer> <leader>h5 I<++>OO##### $a
inoremap <buffer> <leader>fh <++>O> Date: :put =strftime(\"%Y-%m-%d\")kJA  o> Instructor: 
inoremap <buffer> <leader>li [<++>](<++>) <++>:call BackwardMarker(3)
inoremap <buffer> <leader>lr [<++>][<++>] <++>:call BackwardMarker(3)
inoremap <buffer> <leader>im ![<++>](<++>) <++>:call BackwardMarker(3)
inoremap <buffer> <leader>rr [<++>]: <++>:call BackwardMarker(2)
inoremap <buffer> <leader>em *<++>* <++>:call BackwardMarker(2)
inoremap <buffer> <leader>bo **<++>** <++>:call BackwardMarker(2)
inoremap <buffer> <leader>st ~~<++>~~ <++>:call BackwardMarker(2)
inoremap <buffer> <leader>ci `<++>` <++>:call BackwardMarker(2)
inoremap <buffer> <leader>cb ```<++><++>```<++>:call BackwardMarker(3)A
inoremap <buffer> <leader>t1 \| <++> \|\|------\|\| <++> \|:call BackwardMarker(2)
inoremap <buffer> <leader>t2 \| <++> \| <++> \|\|------\|------\|\| <++> \| <++> \|:call BackwardMarker(4)
inoremap <buffer> <leader>t3 \| <++> \| <++> \| <++> \|\|------\|------\|------\|\| <++> \| <++> \| <++> \|:call BackwardMarker(6)
inoremap <buffer> <leader>t4 \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \|:call BackwardMarker(8)
inoremap <buffer> <leader>t5 \| <++> \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \| <++> \|:call BackwardMarker(10)
inoremap <leader>t6 \| <++> \| <++> \| <++> \| <++> \| <++> \| <++> \|\|------\|------\|------\|------\|------\|------\|\| <++> \| <++> \| <++> \| <++> \| <++> \| <++> \|:call BackwardMarker(12)

inoremap <buffer> <leader>qu I<++>OO> 
