packadd! fugitive-gitlab.vim
packadd! vim-gitgutter
packadd! vim-fugitive
packadd! vcs-jump

nnoremap <localleader>fd :VcsJump diff<Space>
nnoremap <localleader>fc :VcsJump merge<Space>
nnoremap <localleader>fg :VcsJump grep<Space>

let g:current_diff_reference = ""

function! Changes(revision) abort
  let g:current_diff_reference=a:revision
  call vcsjump#jump(0, "diff " . a:revision)
endfunction

function! OpenDiff() abort
  if g:current_diff_reference == ""
    echom "Empty revision"
    return 
  endif
  execute("Gvdiffsplit!" . g:current_diff_reference)
endfunction

function! NextChanges() abort
  diffoff
  q
  cnf
  call OpenDiff()
endfunction

function! PreviousChanges() abort
  diffoff
  q
  cpf
  call OpenDiff()
endfunction

command! -nargs=+ -complete=file DStart call Changes(<q-args>)
command! DNext call NextChanges()
command! DCurrent call OpenDiff()
command! DPrevious call PreviousChanges()

nnoremap <localleader>cd :Gvdiffsplit! <Space>

let diffopt="filler,context:3,iwhiteall,internal"

let g:fugitive_gitlab_domains = ['https://gitlab.xarepo.com']
