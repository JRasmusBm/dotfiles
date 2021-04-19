" Python {{{
" File {{{
inoremap <buffer> <leader>pf """
      \<++>
      \"""
      \import logging
      \logger = logging.getLogger(__name__)
      \<++>
      \if __name__ == "__main__":
      \pass:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd def <++>(<++>):<++><++><<:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Argument {{{
inoremap <buffer> <leader>fa <++>, <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Inline {{{
inoremap <buffer> <leader>fi lambda <++>: <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" Variable {{{
" Definition {{{
inoremap <buffer> <leader>vd <++> = <++><++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Attribute {{{
inoremap <buffer> <leader>va self.<++> = <++><++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" }}}

" Plot {{{
" Block {{{
inoremap <buffer> <leader>pb plt.figure(<++>)
            \title_string = "<++>"
            \subtitle_string = "<++>"
            \plt.suptitle(title_string, fontsize=16)
            \plt.title(subtitle_string, fontsize=12)
            \plt.ylabel("<++>")
            \plt.xlabel("<++>")
            \<++>
            \plt.legend()
            \plt.savefig(<++>)
            \plt.close():call jrasmusbm#snippets#backward_marker(7)
" }}}
" Object {{{
inoremap <buffer> <leader>po plt.<++>(
            \<++>,
            \label=<++>,
            \color=<++>,
            \)
            \<++>:call jrasmusbm#snippets#backward_marker(5)
" }}}
" }}}
"
" Class {{{
" Definition {{{
inoremap <buffer> <leader>cd class <++>:<++><++><<:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Attribute {{{
inoremap <buffer> <leader>ca self.
"}}}
"}}}

" Logging {{{
" Format {{{
inoremap <buffer> <leader>lf pformat(<++>)<++>:call jrasmusbm#snippets#backward_marker()
" Info {{{
inoremap <buffer> <leader>li logger.info(<++>)<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Timestamps {{{
inoremap <buffer> <leader>lt logger.debug(f"Start <++>...")
      \start = time()
      \end = time()
      \logger.debug(f"Done <++>. {end - start} s"):call jrasmusbm#snippets#backward_marker(2)
"}}}
" Warning {{{
inoremap <buffer> <leader>lw logger.warning(<++>)<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Error {{{
"}}}
inoremap <buffer> <leader>le logger.error(<++>)<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Debug {{{
inoremap <buffer> <leader>ld logger.debug(<++>)<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Print {{{
inoremap <buffer> <leader>ll print(<++>)<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Breakpoint {{{
inoremap <buffer> <leader>lb print(dict(
      \file = "%",
      \line = =line("."),
      \<++>
      \));:call jrasmusbm#snippets#backward_marker(1)
" )}}
"}}}

" Object {{{
" Identifier {{{
inoremap <buffer> <leader>oi __<++>__<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Method {{{
inoremap <buffer> <leader>om def __<++>__(self, <++>):<++><++><<$:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}

" Import {{{
" Named {{{
inoremap <buffer> <leader>in from <++> import <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Module {{{
inoremap <buffer> <leader>im import <++> <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" GraphQL {{{
" ResolveInfo {{{
inoremap <buffer> <leader>qri from graphql.execution.base import ResolveInfo
  \<++>:call jrasmusbm#snippets#backward_marker(1)
" }}}
" Resolver {{{
inoremap <buffer> <leader>qr ?classn:nohwyw2i	@staticmethod
  \def resolve_<++>(_parent: """, _info: ResolveInfo<++>) -> <++>:
  \<++>:call jrasmusbm#snippets#backward_marker(4)
" }}}
" Mutation {{{
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
  \def mutate(_parent: "<++>", _info: ResolveInfo) -> "<++>":
  \"""<++>"""
  \<++>:call jrasmusbm#snippets#backward_marker(10)
" }}}
" }}}

" Arguments{{{
" Named {{{
inoremap <buffer> <leader>an <++>=<++>,<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Typed {{{
inoremap <buffer> <leader>at <++>: <++>,<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
"}}}

" Control Statements{{{
" With{{{
inoremap <buffer> <leader>cwi with <++>:<++><++><<:call jrasmusbm#snippets#backward_marker(3)
"}}}
" If {{{
" Statement {{{
inoremap <buffer> <leader>ci if <++>:<++><++><<:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Else {{{
inoremap <buffer> <leader>ce else:<++><++><<:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Elif {{{
inoremap <buffer> <leader>cei elif <++>:<++><++><<:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Ternary {{{
inoremap <buffer> <leader>ct <++> if <++> else <++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}
" Try {{{
inoremap <buffer> <leader>ct try:
  \<++>
  \except <++>:
  \<++>
  \<++><<:call jrasmusbm#snippets#backward_marker(3)
" }}}
" For {{{
" Each {{{
inoremap <buffer> <leader>cfe for <++> in <++>:
      \<++>
      \<++><<:call jrasmusbm#snippets#backward_marker(4)
" }}}
" }}}
" Index {{{
inoremap <buffer> <leader>cfo for <++> in range(<++>):
      \<++>
      \<++><<:call jrasmusbm#snippets#backward_marker(4)
" }}}
" Index {{{
inoremap <buffer> <leader>cfi for <++> in <++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
"}}}

" Testing{{{
" Suite {{{
inoremap <buffer> <leader>ds class Test<++>:<++><++><<:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Case {{{
inoremap <buffer> <leader>dc def test_<++>(self, <++>) -> None:
      \raise Exception("Not Implemented!")
      \<++><<:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Before Each {{{
inoremap <buffer> <leader>db @pytest.fixture
  \def <++>() -> <++>:
  \<++><++><<:call jrasmusbm#snippets#backward_marker(4)
" }}}
" Expect {{{
inoremap <buffer> <leader>de assert <++><++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Test File {{{
inoremap <buffer> <leader>df """<++>"""
  \import pytest
  \@pytest.fixturedef <++>() -> <++>:
  \"""<++>"""<++>
  \class Test<++>:<<A"""<++>"""
  \def test_<++>(self,<++>) -> None:
  \raise Exception("Not Implemented!"):call jrasmusbm#snippets#backward_marker(9)
"}}}
" Conftest File{{{
inoremap <buffer> <leader>dh """<++>"""
  \import pytest
  \@pytest.fixturedef <++>() -> <++>:
  \"""<++>"""<++>
  \:call jrasmusbm#snippets#backward_marker(5)
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
  \<++>:call jrasmusbm#snippets#backward_marker(5)
" }}}
" Column {{{
inoremap <buffer> <leader>mc <++> = Column(<++>)
  \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Primary Key {{{
inoremap <buffer> <leader>mp __table_args__ = (
      \PrimaryKeyConstraint("<++>", "<++>", name="<++>"),
      \)
      \<++>:call jrasmusbm#snippets#backward_marker(4)
" }}}
" }}}
