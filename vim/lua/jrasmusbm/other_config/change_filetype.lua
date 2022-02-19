vim.cmd [[
augroup ChangeFiletype
  autocmd!
  autocmd BufNew,BufNewFile,BufRead *.j set filetype=jasmin
  autocmd BufNew,BufNewFile,BufRead .eslintrc,.babelrc,.stylelintrc,.swcrc,.prettierrc set filetype=json
  autocmd BufNew,BufNewFile,BufRead .pylintrc,.coveragerc,.flake8 set filetype=dosini
  autocmd BufNew,BufNewFile,BufRead .tmux,.tmux-default,.env* set filetype=sh
  autocmd BufNew,BufNewFile,BufRead *.tsx set filetype=typescript.tsx
  autocmd BufNew,BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNew,BufNewFile,BufRead .sequelizerc set filetype=javascript
  autocmd BufNew,BufNewFile,BufRead *.graphql set filetype=graphql
  autocmd BufNew,BufNewFile,BufRead gitconfig set filetype=gitconfig
  autocmd BufNew,BufNewFile,BufRead *.toml set filetype=toml
  autocmd BufNew,BufNewFile,BufRead *.scm set filetype=query
  autocmd BufNew,BufNewFile,BufRead Dockerfile* set filetype=dockerfile
  autocmd BufNew,BufNewFile,BufRead serviceworker.ts set filetype=typescript.serviceworker
  autocmd BufNew,BufNewFile,BufRead serviceworker.js set filetype=javascript.serviceworker
  autocmd BufNew,BufNewFile,BufRead .tmux-speeddial set filetype=speeddial
augroup END
]]
