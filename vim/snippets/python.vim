"Function Definition
inoremap <buffer> <leader>fd def <++>(<++>):<++><++><<:call BackwardMarker(3)
inoremap <buffer> <leader>fa <++>, <++>:call BackwardMarker(2)
inoremap <buffer> <leader>fi lambda <++>: <++>:call BackwardMarker(2)
"Class Definition
inoremap <buffer> <leader>cd class <++>:<++><++><<:call BackwardMarker(2)
"Print
inoremap <buffer> <leader>pr print(<++>)<++>:call BackwardMarker(2)
"Dunder Declaration
inoremap <buffer> <leader>oi __<++>__ <++> :call BackwardMarker(2)
inoremap <buffer> <leader>om def __<++>__(self, <++>):<++><++><<$:call BackwardMarker(4)
inoremap <buffer> <leader>in from <++> import <++>:call BackwardMarker(2)
inoremap <buffer> <leader>im import <++> <++>:call BackwardMarker(2)
" GraphQL {{{
" resolver{{{
inoremap <buffer> <leader>qr @staticmethod
  \async def resolve_<++>(_parent: Dict, _info: ResolveInfo<++>):
  \<++>:call BackwardMarker(3)
" }}}
" }}}
" Arguments{{{
" Named {{{
inoremap <buffer> <leader>an <++>=<++>,<++>:call BackwardMarker(3)
" }}}
" Typed {{{
inoremap <buffer> <leader>at <++>: <++>,<++>:call BackwardMarker(3)
" }}}
"}}}
" Control Statements{{{
" With{{{
inoremap <buffer> <leader>cwi with <++>:<++><++><<:call BackwardMarker(2)
"}}}
" If {{{
inoremap <buffer> <leader>ci if <++>:<++><++><<:call BackwardMarker(2)
inoremap <buffer> <leader>ce else:<++><++><<:call BackwardMarker(1)
inoremap <buffer> <leader>cei elif <++>:<++><++><<:call BackwardMarker(2)
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
