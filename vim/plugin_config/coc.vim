packadd! coc.nvim

let g:coc_global_extensions=[
  \"coc-prettier",
  \"coc-python",
  \"coc-lua",
  \"coc-json",
  \"coc-html",
  \"coc-vetur",
  \"coc-yaml",
  \"coc-python",
  \"coc-texlab",
  \"coc-tsserver",
  \"coc-eslint",
  \"coc-rls"
  \]

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

let g:jedi#auto_initialization=0
