Plug 'neoclide/coc.nvim', {'branch': 'release'}

nmap <leader>ad <Plug>(coc-definition)
nmap <leader>at <Plug>(coc-type-definition)
nmap <leader>ai <Plug>(coc-implementation)
nmap <leader>ar <Plug>(coc-references)
nmap <leader>ah :call CocAction("doHover")
nmap <silent> [v <Plug>(coc-diagnostic-prev)
nmap <silent> ]v <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <leader>af :call CocAction("format")

let g:coc_global_extensions=[
  \"coc-prettier",
  \"coc-python",
  \"coc-json",
  \"coc-html",
  \"coc-yaml",
  \"coc-python",
  \"coc-highlight",
  \"coc-texlab",
  \"coc-tsserver"
  \]