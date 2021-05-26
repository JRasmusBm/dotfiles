function! jrasmusbm#colors#show_highlight() abort
    let name = 'hi<' . synIDattr(synID(line("."),col("."),1),"name") . '>' 
    let trans =  'trans<' . synIDattr(synID(line("."),col("."),0),"name") . '>'
    let location = 'lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . '>'
    echo name . ' ' . trans . ' ' . location
endfunction
