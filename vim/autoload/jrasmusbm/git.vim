let g:git_commit_tree_file="temp_git_tree"

function! jrasmusbm#git#open_tree(num_lines = 1000) abort
  exec "e " . g:git_commit_tree_file
  set ft=git-commit-tree
  call jrasmusbm#git#list_tree(a:num_lines)
endfunction

function! jrasmusbm#git#list_tree(num_lines = 1000) abort
  if &ft == "git-commit-tree"
    exec "%!git --no-pager log --oneline --decorate --graph --all -" .. a:num_lines
    w
  endif
endfunction

function! jrasmusbm#git#G_command(...) abort
  let arguments = join(a:000, " ")

  if arguments == "" || arguments == " "
    silent e .git/index
    return "silent e .git/index"
  endif

  return "Git " . arguments
endfunction

function! jrasmusbm#git#run_and_refresh(command) abort
  exec a:command
  silent call jrasmusbm#git#list_tree()
endfunction

function! jrasmusbm#git#push_all() abort
  wa!
  G wip
  G rbof
  G push
endfunction
