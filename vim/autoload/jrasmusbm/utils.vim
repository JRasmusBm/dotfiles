function! jrasmusbm#utils#get_lines(...) abort
  return [line("'["), line("']")]
endfunction

function! jrasmusbm#utils#column_from_right() abort
  let cur_pos = getpos('.')
  normal! $
  let last_col = col('.')
  call setpos('.', cur_pos)
  return last_col + 1 - cur_pos[2]
endfunction
