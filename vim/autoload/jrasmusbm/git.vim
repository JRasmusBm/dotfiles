let g:git_commit_tree_file="temp_git_tree"

function! jrasmusbm#git#open_tree() abort
  exec "e " . g:git_commit_tree_file
  call jrasmusbm#git#list_tree()
endfunction

function! jrasmusbm#git#list_tree() abort
  exec "%!git --no-pager log --oneline --decorate --graph --all -50"
  set ft=git-commit-tree
  w
endfunction

function! jrasmusbm#git#run_and_refresh(...) abort
  let arguments = ""

  for s in a:000  " a list
    let arguments .= ' ' . s
  endfor

  let cmd = "Git" . arguments
  exec cmd
  silent call jrasmusbm#git#list_tree()
endfunction
