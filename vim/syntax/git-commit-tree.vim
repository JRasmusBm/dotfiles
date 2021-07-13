if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'git-commit-tree'

syntax match GitCommitTreeHash                                                 /\v%([*|] )@<=[0-9a-f]+/
syntax match GitCommitTreeRef                                                  /\v%( \()@<=([^)~\\:^]|tag:)+\ze\)/
syntax match GitCommitTreeRefTag        contained containedin=GitCommitTreeRef /\vtag: .{-}\ze[),]/
syntax match GitCommitTreeRefRemote     contained containedin=GitCommitTreeRef /\v(origin|upstream)+\/.{-}\ze[),]/
syntax match GitCommitTreeRefHead       contained containedin=GitCommitTreeRef nextgroup=GitCommitTreeRefHeadArrow  /\v<HEAD/
syntax match GitCommitTreeRefHeadArrow  contained                              nextgroup=GitCommitTreeRefHeadBranch / -> /
syntax match GitCommitTreeRefHeadBranch contained                                                 /[^,)]\+/

highlight default link GitCommitTreeHash TSType
highlight default link GitCommitTreeRef TSProperty
highlight default link GitCommitTreeRefTag TSNamespace
highlight default link GitCommitTreeRefRemote Keyword
highlight default link GitCommitTreeRefHead TSConstBuiltin
highlight default link GitCommitTreeRefHeadArrow TSConstBuiltin
highlight default link GitCommitTreeRefHeadBranch TSProperty

syntax match GitCommitTreeGraphEdge9 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge1,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge8 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge9,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge7 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge8,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge6 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge7,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge5 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge6,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge4 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge5,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge3 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge4,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge2 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge3,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge1 /[_/ ]\?[|/\\*]/  nextgroup=GitCommitTreeGraphEdge2,@GitCommitTreeDiff contained
syntax match GitCommitTreeGraphEdge0 /^[_/ ]\?[|/\\*]/ nextgroup=GitCommitTreeGraphEdge2,@GitCommitTreeDiff

syntax cluster GitCommitTreeGraphEdge contains=GitCommitTreeGraphEdge0,GitCommitTreeGraphEdge1,GitCommitTreeGraphEdge2,GitCommitTreeGraphEdge3,GitCommitTreeGraphEdge4,GitCommitTreeGraphEdge5,GitCommitTreeGraphEdge6,GitCommitTreeGraphEdge7,GitCommitTreeGraphEdge8,GitCommitTreeGraphEdge9

syntax match GitCommitTreeGraphCrossing /_\|\/\ze|/ contained containedin=@GitCommitTreeGraphEdge
syntax match GitCommitTreeGraphCommit /\*/ contained containedin=@GitCommitTreeGraphEdge

if &background ==# 'dark'
  highlight default GitCommitTreeGraphEdge1 ctermfg=magenta     guifg=green1
  highlight link    GitCommitTreeGraphEdge0 GitCommitTreeGraphEdge1
  highlight default GitCommitTreeGraphEdge2 ctermfg=green       guifg=yellow1
  highlight default GitCommitTreeGraphEdge3 ctermfg=yellow      guifg=orange1
  highlight default GitCommitTreeGraphEdge4 ctermfg=cyan        guifg=greenyellow
  highlight default GitCommitTreeGraphEdge5 ctermfg=red         guifg=springgreen1
  highlight default GitCommitTreeGraphEdge6 ctermfg=yellow      guifg=cyan1
  highlight default GitCommitTreeGraphEdge7 ctermfg=green       guifg=slateblue1
  highlight default GitCommitTreeGraphEdge8 ctermfg=cyan        guifg=magenta1
  highlight default GitCommitTreeGraphEdge9 ctermfg=magenta     guifg=purple1
else
  highlight default GitCommitTreeGraphEdge1 ctermfg=darkyellow  guifg=orangered3
  highlight default GitCommitTreeGraphEdge2 ctermfg=darkgreen   guifg=orange2
  highlight default GitCommitTreeGraphEdge3 ctermfg=blue        guifg=yellow3
  highlight default GitCommitTreeGraphEdge4 ctermfg=darkmagenta guifg=olivedrab4
  highlight default GitCommitTreeGraphEdge5 ctermfg=red         guifg=green4
  highlight default GitCommitTreeGraphEdge6 ctermfg=darkyellow  guifg=paleturquoise3
  highlight default GitCommitTreeGraphEdge7 ctermfg=darkgreen   guifg=deepskyblue4
  highlight default GitCommitTreeGraphEdge8 ctermfg=blue        guifg=darkslateblue
  highlight default GitCommitTreeGraphEdge9 ctermfg=darkmagenta guifg=darkviolet
endif
