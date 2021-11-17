let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[40;2;%lu;%lu;%lum"

let g:gruvbox_material_palette = 'material'
colorscheme gruvbox-material

lua require("jrasmusbm.statusline").setup()

call jrasmusbm#colors#update_highlights()
