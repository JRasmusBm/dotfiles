packadd! coc.nvim

nnoremap <leader>a :CocAction
nnoremap  <Plug>(coc-definition)
nnoremap gt <Plug>(coc-type-definition)
nnoremap gD <Plug>(coc-implementation)
nnoremap gr <Plug>(coc-references)
nnoremap K :call CocAction("doHover")
nnoremap <silent> [v <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]v <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <c-space> coc#refresh()

nnoremap Q :call CocAction("format")
vnoremap Q :call CocAction("formatSelected")

let g:coc_global_extensions=[
  \"coc-prettier",
  \"coc-python",
  \"coc-json",
  \"coc-html",
  \"coc-yaml",
  \"coc-python",
  \"coc-texlab",
  \"coc-tsserver",
  \"coc-eslint",
  \"coc-rls"
  \]

let g:jedi#auto_initialization=0
