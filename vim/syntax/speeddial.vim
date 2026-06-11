" The speeddial filetype (wt board order files, ts-* profiles,
" branch_speeddial) has no syntax of its own — borrow
" markdown's so the `# SECTION` headings stand out. Sourced by
" the syntax machinery when `:set syntax=speeddial` runs, so it
" wins cleanly without fighting the FileType syntaxset autocmd.
" markdown.vim sets b:current_syntax = "markdown" itself.
runtime! syntax/markdown.vim
