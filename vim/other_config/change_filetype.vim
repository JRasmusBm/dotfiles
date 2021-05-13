augroup ChangeFiletype
  autocmd BufRead, BufNewFile *.j set filetype=jasmin
  autocmd BufRead .eslintrc,.babelrc,.stylelintrc,.prettierrc set filetype=json
  autocmd BufRead *.pl set filetype=prolog
  autocmd BufRead .pylintrc,.coveragerc set filetype=dosini
  autocmd BufRead .tmux,.tmux-default,.env* set filetype=sh
  autocmd BufRead *.tsx set filetype=typescript.tsx
  autocmd BufRead *.jsx set filetype=javascript.jsx
  autocmd BufRead .sequelizerc set filetype=javascript
  autocmd BufRead *.graphql set filetype=graphql
  autocmd BufRead gitconfig set filetype=gitconfig
  autocmd BufRead *.toml set filetype=toml
  autocmd BufRead Dockerfile* set filetype=dockerfile
  autocmd BufRead serviceworker.ts set filetype=typescript.serviceworker
  autocmd BufRead serviceworker.js set filetype=javascript.serviceworker
augroup END
