map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#") . " BG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg#")<CR>

" Error Styling{{{
highlight Error guifg=red guibg=NONE ctermfg=red ctermbg=NONE
highlight BadWhitespace guibg=darkred ctermbg=darkred
highlight Search guifg=yellow ctermfg=yellow

" Spelling {{{
highlight SpellBad ctermfg=red guifg=red guibg=NONE ctermbg=NONE
highlight SpellCap ctermfg=red guifg=red guibg=NONE ctermbg=NONE
highlight SpellLocal ctermfg=red guifg=red guibg=NONE ctermbg=NONE
highlight SpellRare ctermfg=red guifg=red guibg=NONE ctermbg=NONE
"}}}
