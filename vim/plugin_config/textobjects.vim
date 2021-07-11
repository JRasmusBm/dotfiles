packadd! vim-textobj-between
packadd! vim-textobj-entire
packadd! vim-textobj-line
packadd! vim-textobj-underscore
packadd! vim-textobj-user

let g:textobj_between_no_default_key_mappings=0

omap ao <Plug>(textobj-between-a)
vmap ao <Plug>(textobj-between-a)
omap io <Plug>(textobj-between-i)
vmap io <Plug>(textobj-between-i)
