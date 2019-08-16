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
" GraphQL {{{
" resolver{{{
inoremap <buffer> <leader>qr @staticmethod
  \async def resolve_<++>(_parent: Dict, _info: ResolveInfo<++>):
  \<++>:call BackwardMarker(3)
" }}}
" }}}
" Control Statements{{{
" With{{{
inoremap <buffer> ;cwi with <++>:<++><++><<:call BackwardMarker(2)
"}}}
" If {{{
inoremap <buffer> ;ci if <++>:<++><++><<:call BackwardMarker(2)
inoremap <buffer> ;ce else:<++><++><<:call BackwardMarker(1)
inoremap <buffer> ;cei elif <++>:<++><++><<:call BackwardMarker(2)
" }}}
"}}}
" Testing{{{
inoremap <buffer> <leader>ds class Test<++>:<++><++><<:call BackwardMarker(2)
inoremap <buffer> <leader>dc async def test_<++>(<++>) -> None:<++><++><<:call BackwardMarker(3)
inoremap <buffer> <leader>db @pytest.fixture
  \async def <++>() -> AsyncGenerator:
  \<++><++><<:call BackwardMarker(2)
inoremap <buffer> <leader>de assert <++><++>:call BackwardMarker(2)
" Test File {{{
inoremap <buffer> <leader>df """<++>"""
  \from typing import AsyncGenerator
  \import pytest
  \@pytest.fixtureasync def <++>() -> AsyncGenerator:
  \"""<++>"""<++>
  \class Test<++>:<<A"""<++>"""
  \async def test_<++>(self,<++>) -> None:
  \"""<++>"""
  \<++>:call BackwardMarker(10)
"}}}
" Conftest File{{{
inoremap <buffer> <leader>dh """<++>"""
  \from typing import AsyncGenerator
  \import pytest
  \@pytest.fixtureasync def <++>() -> AsyncGenerator:
  \"""<++>"""<++>
  \:call BackwardMarker(4)
"}}}
"}}}
