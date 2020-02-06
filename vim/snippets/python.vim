"Function Definition
inoremap <buffer> <leader>fd def <++>(<++>):<++><++><<:call BackwardMarker(4)
inoremap <buffer> <leader>fa <++>, <++>:call BackwardMarker(2)
inoremap <buffer> <leader>fi lambda <++>: <++>:call BackwardMarker(2)
" Variable {{{
" Definition {{{
inoremap <buffer> <leader>vd <++> = <++><++>:call BackwardMarker(3)
" }}}
" }}}
"Class Definition
inoremap <buffer> <leader>cd class <++>:<++><++><<:call BackwardMarker(3)
"Print
inoremap <buffer> <leader>pr print(<++>)<++>:call BackwardMarker(2)
"Dunder Declaration
inoremap <buffer> <leader>oi __<++>__ <++> :call BackwardMarker(2)
inoremap <buffer> <leader>om def __<++>__(self, <++>):<++><++><<$:call BackwardMarker(4)
inoremap <buffer> <leader>in from <++> import <++>:call BackwardMarker(2)
inoremap <buffer> <leader>im import <++> <++>:call BackwardMarker(2)
" GraphQL {{{
" ResolveInfo {{{
inoremap <buffer> <leader>qri from graphql.execution.base import ResolveInfo
  \<++>:call BackwardMarker(1)
" }}}
" resolver{{{
inoremap <buffer> <leader>qr ?classn:nohwyw2i	@staticmethod
  \async def resolve_<++>(_parent: """, _info: ResolveInfo<++>) -> <++>:
  \<++>:call BackwardMarker(4)
" }}}
" mutation{{{
inoremap <buffer> <leader>qm """<++>"""
  \import graphene
  \from graphql.execution.base import ResolveInfo
  \class <++>Mutation(graphene.Mutation):
  \"""<++>"""
  \class Arguments:
  \"""<++>"""
  \<++>
  \ok = graphene.Boolean()<<o
  \<++>
  \@staticmethod
  \async def mutate(_parent: "<++>", _info: ResolveInfo) -> "<++>":
  \"""<++>"""
  \<++>:call BackwardMarker(10)
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
inoremap <buffer> <leader>cwi with <++>:<++><++><<:call BackwardMarker(3)
"}}}
" If {{{
inoremap <buffer> <leader>ci if <++>:<++><++><<:call BackwardMarker(3)
inoremap <buffer> <leader>ce else:<++><++><<:call BackwardMarker(2)
inoremap <buffer> <leader>cei elif <++>:<++><++><<:call BackwardMarker(3)
" }}}
" Try {{{
inoremap <buffer> <leader>ct try:
  \<++>
  \except <++>:
  \<++>
  \<++><<:call BackwardMarker(3)
" }}}
"}}}
" Testing{{{
" Suite {{{
inoremap <buffer> <leader>ds class Test<++>:<++><++><<:call BackwardMarker(2)
" }}}
" Case {{{
inoremap <buffer> <leader>dc async def test_<++>(self, <++>) -> None:
      \"""<++>"""
      \<++>
      \<++><<:call BackwardMarker(4)
" }}}
" Before Each {{{
inoremap <buffer> <leader>db @pytest.fixture
  \async def <++>() -> AsyncGenerator:
  \<++><++><<:call BackwardMarker(2)
" }}}
" Expect {{{
inoremap <buffer> <leader>de assert <++><++>:call BackwardMarker(2)
" }}}
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
" Model {{{
" File {{{
inoremap <buffer> <leader>mf """<++>"""
  \from sqlalchemy import Column, Integer
  \from src.model.db_engine import db_engine
  \class <++>Model(db_engine.base):
  \"""<++>"""
  \__tablename__ = "<++>"
  \id = Column(Integer, primary_key=True)
  \<++>:call BackwardMarker(5)
" }}}
" Column {{{
inoremap <buffer> <leader>mc <++> = Column(<++>)
  \<++>:call BackwardMarker(3)
" }}}
" Primary Key {{{
inoremap <buffer> <leader>mp __table_args__ = (
      \PrimaryKeyConstraint("<++>", "<++>", name="<++>"),
      \)
      \<++>:call BackwardMarker(4)
" }}}
" }}}
