function! LoadRainbowParams()
  hi level1color ctermfg=brown
  hi level2color ctermfg=Darkblue
  hi level3color ctermfg=darkgray
  hi level4color ctermfg=darkgreen
  hi level5color ctermfg=darkcyan
  hi level6color ctermfg=darkred
  hi level7color ctermfg=darkmagenta
  hi level8color ctermfg=brown
  hi level9color ctermfg=gray
  hi level10color ctermfg=black
  hi level11color ctermfg=darkmagenta
  hi level12color ctermfg=Darkblue
  hi level13color ctermfg=darkgreen
  hi level14color ctermfg=darkcyan
  hi level15color ctermfg=darkred
  hi level16color ctermfg=red

  syn region levels1 matchgroup=level1color start=/\[/ end=/\]/ contains=TOP,levels1,levels2,levels3,levels4,levels5,levels6,levels7,levels8,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels2 matchgroup=level2color start=/\[/ end=/\]/ contains=TOP,levels2,levels3,levels4,levels5,levels6,levels7,levels8,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels3 matchgroup=level3color start=/\[/ end=/\]/ contains=TOP,levels3,levels4,levels5,levels6,levels7,levels8,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels4 matchgroup=level4color start=/\[/ end=/\]/ contains=TOP,levels4,levels5,levels6,levels7,levels8,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels5 matchgroup=level5color start=/\[/ end=/\]/ contains=TOP,levels5,levels6,levels7,levels8,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels6 matchgroup=level6color start=/\[/ end=/\]/ contains=TOP,levels6,levels7,levels8,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels7 matchgroup=level7color start=/\[/ end=/\]/ contains=TOP,levels7,levels8,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels8 matchgroup=level8color start=/\[/ end=/\]/ contains=TOP,levels8,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels9 matchgroup=level9color start=/\[/ end=/\]/ contains=TOP,levels9,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels10 matchgroup=level10color start=/\[/ end=/\]/ contains=TOP,levels10,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels11 matchgroup=level11color start=/\[/ end=/\]/ contains=TOP,levels11,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels12 matchgroup=level12color start=/\[/ end=/\]/ contains=TOP,levels12,levels13,levels14,levels15,levels16,NoInParens
  syn region levels13 matchgroup=level13color start=/\[/ end=/\]/ contains=TOP,levels13,levels14,levels15,levels16,NoInParens
  syn region levels14 matchgroup=level14color start=/\[/ end=/\]/ contains=TOP,levels14,levels15,levels16,NoInParens
  syn region levels15 matchgroup=level15color start=/\[/ end=/\]/ contains=TOP,levels15,levels16,NoInParens
  syn region levels16 matchgroup=level16color start=/\[/ end=/\]/ contains=TOP,levels16,NoInParens

  syn region levelb1 matchgroup=level1color start=/(/ end=/)/ contains=TOP,levelb1,levelb2,levelb3,levelb4,levelb5,levelb6,levelb7,levelb8,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb2 matchgroup=level2color start=/(/ end=/)/ contains=TOP,levelb2,levelb3,levelb4,levelb5,levelb6,levelb7,levelb8,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb3 matchgroup=level3color start=/(/ end=/)/ contains=TOP,levelb3,levelb4,levelb5,levelb6,levelb7,levelb8,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb4 matchgroup=level4color start=/(/ end=/)/ contains=TOP,levelb4,levelb5,levelb6,levelb7,levelb8,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb5 matchgroup=level5color start=/(/ end=/)/ contains=TOP,levelb5,levelb6,levelb7,levelb8,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb6 matchgroup=level6color start=/(/ end=/)/ contains=TOP,levelb6,levelb7,levelb8,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb7 matchgroup=level7color start=/(/ end=/)/ contains=TOP,levelb7,levelb8,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb8 matchgroup=level8color start=/(/ end=/)/ contains=TOP,levelb8,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb9 matchgroup=level9color start=/(/ end=/)/ contains=TOP,levelb9,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb10 matchgroup=level10color start=/(/ end=/)/ contains=TOP,levelb10,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb11 matchgroup=level11color start=/(/ end=/)/ contains=TOP,levelb11,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb12 matchgroup=level12color start=/(/ end=/)/ contains=TOP,levelb12,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb13 matchgroup=level13color start=/(/ end=/)/ contains=TOP,levelb13,levelb14,levelb15,levelb16,NoInParens
  syn region levelb14 matchgroup=level14color start=/(/ end=/)/ contains=TOP,levelb14,levelb15,levelb16,NoInParens
  syn region levelb15 matchgroup=level15color start=/(/ end=/)/ contains=TOP,levelb15,levelb16,NoInParens
  syn region levelb16 matchgroup=level16color start=/(/ end=/)/ contains=TOP,levelb16,NoInParens

  syn region levelc1 matchgroup=level1color start=/{/ end=/}/ contains=TOP,levelc1,levelc2,levelc3,levelc4,levelc5,levelc6,levelc7,levelc8,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc2 matchgroup=level2color start=/{/ end=/}/ contains=TOP,levelc2,levelc3,levelc4,levelc5,levelc6,levelc7,levelc8,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc3 matchgroup=level3color start=/{/ end=/}/ contains=TOP,levelc3,levelc4,levelc5,levelc6,levelc7,levelc8,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc4 matchgroup=level4color start=/{/ end=/}/ contains=TOP,levelc4,levelc5,levelc6,levelc7,levelc8,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc5 matchgroup=level5color start=/{/ end=/}/ contains=TOP,levelc5,levelc6,levelc7,levelc8,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc6 matchgroup=level6color start=/{/ end=/}/ contains=TOP,levelc6,levelc7,levelc8,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc7 matchgroup=level7color start=/{/ end=/}/ contains=TOP,levelc7,levelc8,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc8 matchgroup=level8color start=/{/ end=/}/ contains=TOP,levelc8,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc9 matchgroup=level9color start=/{/ end=/}/ contains=TOP,levelc9,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc10 matchgroup=level10color start=/{/ end=/}/ contains=TOP,levelc10,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc11 matchgroup=level11color start=/{/ end=/}/ contains=TOP,levelc11,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc12 matchgroup=level12color start=/{/ end=/}/ contains=TOP,levelc12,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc13 matchgroup=level13color start=/{/ end=/}/ contains=TOP,levelc13,levelc14,levelc15,levelc16,NoInParens
  syn region levelc14 matchgroup=level14color start=/{/ end=/}/ contains=TOP,levelc14,levelc15,levelc16,NoInParens
  syn region levelc15 matchgroup=level15color start=/{/ end=/}/ contains=TOP,levelc15,levelc16,NoInParens
  syn region levelc16 matchgroup=level16color start=/{/ end=/}/ contains=TOP,levelc16,NoInParens
endfunction
