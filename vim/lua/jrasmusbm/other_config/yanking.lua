vim.cmd [[
nnoremap <C-Y> "+y
nnoremap <C-P> "+p
vnoremap <C-Y> "+y
vnoremap <C-P> "+p

augroup ShowYank
  if exists('##TextYankPost')
    autocmd TextYankPost * lua vim.highlight.on_yank {higroup='IncSearch', timeout=200}
  endif
augroup END
]]
