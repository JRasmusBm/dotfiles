function! jrasmusbm#open#github() abort
    let l:line_number = line('.')
    let l:line = getbufline(bufnr("%"), l:line_number)[0]
    let l:column_start = getpos("v")[2]
    let l:column_end = getpos(".")[2]
    let l:selection = strpart(l:line, l:column_start - 1, l:column_end - l:column_start + 1)
    call system('git-repo ' . selection)
endfunction
