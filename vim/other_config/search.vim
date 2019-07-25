nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz

nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap n nzzzv
vnoremap N Nzzzv

function! UpdateX()
  let @x = @/[2:-3]
endfunction

nnoremap * *:call UpdateX()
nnoremap # #:call UpdateX()
