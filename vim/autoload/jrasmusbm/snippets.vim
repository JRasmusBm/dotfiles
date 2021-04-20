function! jrasmusbm#snippets#change_marker() abort
  if jrasmusbm#utils#column_from_right() == 4
    normal "_dgn
    execute 'startinsert!'
  else
    normal "_dgn
    execute 'startinsert'
  endif
endfunction

function! jrasmusbm#snippets#backward_marker(n)
  if a:n > 0
    execute 'normal! ?<++> '  . a:n . 'n"'
  else
    execute 'normal! ?<++>"'
  endif
  call jrasmusbm#snippets#change_marker()
endfunction

function! jrasmusbm#snippets#forward_marker(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n"'
  else
    execute 'normal! /<++>"'
  endif
  call jrasmusbm#snippets#change_marker()
endfunction

function! jrasmusbm#snippets#delete_all_markers()
  let save_pos = getpos('.')
  execute '%s/<++>//g'
  call setpos('.', save_pos)
endfunction

function! DeleteMarker(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n'
  else
    execute 'normal! /<++>'
  endif
  normal "_dgn
endfunction

function! jrasmusbm#snippets#delete_marker_row(n)
  if a:n > 1
    execute 'normal! /<++> '  . (a:n - 1) . 'n"_dd'
  else
    execute 'normal! /<++>"_dd'
  endif
endfunction
