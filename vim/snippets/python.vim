"Function Definition
inoremap <buffer> ;fd def <++>(<++>):<++><++><<:call BackwardMarker(3)
inoremap <buffer> ;fa <++>, <++>:call BackwardMarker(2)
inoremap <buffer> ;fi lambda <++>: <++>:call BackwardMarker(2)
"Class Definition
inoremap <buffer> ;cd class <++>:<++><++><<:call BackwardMarker(2)
"Print
inoremap <buffer> ;pr print(<++>)<++>:call BackwardMarker(2)
"Dunder Declaration
inoremap <buffer> ;oi __<++>__ <++> :call BackwardMarker(2)
inoremap <buffer> ;om def __<++>__(self, <++>):<++><++><<$:call BackwardMarker(4)
inoremap <buffer> ;in from <++> import <++>:call BackwardMarker(2)
inoremap <buffer> ;im import <++> <++>:call BackwardMarker(2)
" With
inoremap <buffer> ;wi with <++>:<++><++><<:call BackwardMarker(2)
inoremap <buffer> ;si if <++>:<++><++><<:call BackwardMarker(2)
" Testing
inoremap <buffer> <leader>ds class Test<++>:<++><++><<:call BackwardMarker(2)
inoremap <buffer> <leader>dc async def test_<++>(<++>):<++><++><<:call BackwardMarker(3)
inoremap <buffer> <leader>db @pytest.fixtureasync def <++>():<++><++><<:call BackwardMarker(2)
inoremap <buffer> <leader>de assert <++><++>:call BackwardMarker(2)
