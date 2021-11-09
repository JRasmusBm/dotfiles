vim.cmd [[ packadd! vim-caser ]]

vim.g.caser_no_mappings = 1

" Pascal{{{
nmap <localleader>cp <Plug>CaserMixedCase
vmap <localleader>cp <Plug>CaserVMixedCase
"}}}

" Camel {{{
nmap <localleader>cc <Plug>CaserCamelCase
vmap <localleader>cc <Plug>CaserVCamelCase
"}}}

" Snake {{{
nmap <localleader>cs <Plug>CaserSnakeCase
vmap <localleader>cs <Plug>CaserVSnakeCase
"}}}

" Upper {{{
nmap <localleader>cu <Plug>CaserUpperCase
vmap <localleader>cu <Plug>CaserVUpperCase
"}}}

" Words {{{
" Title {{{
nmap <localleader>cwt <Plug>CaserTitleCase
vmap <localleader>cwt <Plug>CaserVTitleCase
"}}}

" Sentence {{{
nmap <localleader>cws <Plug>CaserSentenceCase
vmap <localleader>cws <Plug>CaserVSentenceCase
"}}}

" Lower {{{
nmap <localleader>cwl <Plug>CaserKebabCase
vmap <localleader>cwl <Plug>CaserVKebabCase
" }}}
"}}}

" Kebab {{{
" Lower {{{
nmap <localleader>ck <Plug>CaserKebabCase
vmap <localleader>ck <Plug>CaserVKebabCase
"}}}

" Upper {{{
nmap <localleader>cK <Plug>CaserTitleKebabCase
vmap <localleader>cK <Plug>CaserVTitleKebabCase
"}}}
"}}}

" Dot {{{
nmap <localleader>cd <Plug>CaserDotCase
vmap <localleader>cd <Plug>CaserVDotCase
"}}}
