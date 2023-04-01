let g:git_commit_tree_file="temp_git_tree"

function! jrasmusbm#git#open_tree(num_lines = 500) abort
  exec "e " . g:git_commit_tree_file
  set ft=git-commit-tree
  call jrasmusbm#git#list_tree(a:num_lines)
endfunction

function! jrasmusbm#git#list_tree(num_lines = 500) abort
  if &ft == "git-commit-tree"
    exec "%!git --no-pager log --oneline --decorate --graph " .. get(g:, "jrasmusbm#git#log_excludes", "") .. " --all -" .. a:num_lines
    w
  endif
endfunction

function! jrasmusbm#git#push_all() abort
  wa!
  G wip
  G rbof
  G push --no-verify
endfunction
