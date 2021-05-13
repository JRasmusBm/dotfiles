packadd! coc.nvim

let g:coc_filetype_map = {
  \ 'typescript.typescript_mocha': 'typescript',
  \ 'typescript.serviceworker': 'typescript',
  \ 'javascript.serviceworker': 'javascript',
  \ 'typescript.express': 'typescript',
  \ 'javascript.express': 'javascript',
  \ 'typescript.react': 'typescript',
  \ 'typescriptreact.react': 'typescriptreact',
  \ 'javascript.react': 'javascript',
  \ 'javascriptreact.react': 'javascriptreact',
  \ }

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
