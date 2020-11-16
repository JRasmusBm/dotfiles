" Python {{{
" File {{{
inoremap <buffer> <leader>pf """
      \<++>
      \"""
      \import logging
      \logger = logging.getLogger(__name__)
      \<++>
      \if __name__ == "__main__":
      \pass:call BackwardMarker(2)
" }}}
" }}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd def <++>(<++>):<++><++><<:call BackwardMarker(4)
"}}}
" Argument {{{
inoremap <buffer> <leader>fa <++>, <++>:call BackwardMarker(2)
"}}}
" Inline {{{
inoremap <buffer> <leader>fi lambda <++>: <++>:call BackwardMarker(2)
"}}}
"}}}

" Variable {{{
" Definition {{{
inoremap <buffer> <leader>vd <++> = <++><++>:call BackwardMarker(3)
" }}}
" Attribute {{{
inoremap <buffer> <leader>va self.<++> = <++><++>:call BackwardMarker(3)
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
            \plt.close():call BackwardMarker(7)
" }}}
" Object {{{
inoremap <buffer> <leader>po plt.<++>(
            \<++>,
            \label=<++>,
            \color=<++>,
            \)
            \<++>:call BackwardMarker(5)
" }}}
" }}}
"
" Class {{{
" Definition {{{
inoremap <buffer> <leader>cd class <++>:<++><++><<:call BackwardMarker(3)
"}}}
" Attribute {{{
inoremap <buffer> <leader>ca self.
"}}}
"}}}

" Logging {{{
" Format {{{
inoremap <buffer> <leader>lf pformat(<++>)<++>:call BackwardMarker()
" Info {{{
inoremap <buffer> <leader>li logger.info(<++>)<++>:call BackwardMarker(2)
"}}}
" Timestamps {{{
inoremap <buffer> <leader>lt logger.debug(f"Start <++>...")
      \start = time()
      \end = time()
      \logger.debug(f"Done <++>. {end - start} s"):call BackwardMarker(2)
"}}}
" Warning {{{
inoremap <buffer> <leader>lw logger.warning(<++>)<++>:call BackwardMarker(2)
"}}}
" Error {{{
"}}}
inoremap <buffer> <leader>le logger.error(<++>)<++>:call BackwardMarker(2)
"}}}
" Debug {{{
inoremap <buffer> <leader>ld logger.debug(<++>)<++>:call BackwardMarker(2)
"}}}
" Print {{{
inoremap <buffer> <leader>ll print(<++>)<++>:call BackwardMarker(2)
"}}}
"}}}

" Object {{{
" Identifier {{{
inoremap <buffer> <leader>oi __<++>__<++>:call BackwardMarker(2)
"}}}
" Method {{{
inoremap <buffer> <leader>om def __<++>__(self, <++>):<++><++><<$:call BackwardMarker(4)
"}}}
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,<++>:call BackwardMarker(3)
"}}}
"}}}

" Import {{{
" Named {{{
inoremap <buffer> <leader>in from <++> import <++>:call BackwardMarker(2)
"}}}
" Module {{{
inoremap <buffer> <leader>im import <++> <++>:call BackwardMarker(2)
"}}}
"}}}

" GraphQL {{{
" ResolveInfo {{{
inoremap <buffer> <leader>qri from graphql.execution.base import ResolveInfo
  \<++>:call BackwardMarker(1)
" }}}
" Resolver {{{
inoremap <buffer> <leader>qr ?classn:nohwyw2i	@staticmethod
  \def resolve_<++>(_parent: """, _info: ResolveInfo<++>) -> <++>:
  \<++>:call BackwardMarker(4)
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
" Statement {{{
inoremap <buffer> <leader>ci if <++>:<++><++><<:call BackwardMarker(3)
"}}}
" Else {{{
inoremap <buffer> <leader>ce else:<++><++><<:call BackwardMarker(2)
"}}}
" Elif {{{
inoremap <buffer> <leader>cei elif <++>:<++><++><<:call BackwardMarker(3)
"}}}
" Ternary {{{
inoremap <buffer> <leader>ct <++> if <++> else <++>:call BackwardMarker(3)
" }}}
" }}}
" Try {{{
inoremap <buffer> <leader>ct try:
  \<++>
  \except <++>:
  \<++>
  \<++><<:call BackwardMarker(3)
" }}}
" For {{{
" Each {{{
inoremap <buffer> <leader>cfe for <++> in <++>:
      \<++>
      \<++><<:call BackwardMarker(4)
" }}}
" }}}
" Index {{{
inoremap <buffer> <leader>cfo for <++> in range(<++>):
      \<++>
      \<++><<:call BackwardMarker(4)
" }}}
" Index {{{
inoremap <buffer> <leader>cfi for <++> in <++>:call BackwardMarker(2)
" }}}
"}}}

" Testing{{{
" Suite {{{
inoremap <buffer> <leader>ds class Test<++>:<++><++><<:call BackwardMarker(2)
" }}}
" Case {{{
inoremap <buffer> <leader>dc def test_<++>(self, <++>) -> None:
      \raise Exception("Not Implemented!")
      \<++><<:call BackwardMarker(3)
" }}}
" Before Each {{{
inoremap <buffer> <leader>db @pytest.fixture
  \def <++>() -> <++>:
  \<++><++><<:call BackwardMarker(3)
" }}}
" Expect {{{
inoremap <buffer> <leader>de assert <++><++>:call BackwardMarker(2)
" }}}
" Test File {{{
inoremap <buffer> <leader>df """<++>"""
  \import pytest
  \@pytest.fixturedef <++>() -> <++>:
  \"""<++>"""<++>
  \class Test<++>:<<A"""<++>"""
  \def test_<++>(self,<++>) -> None:
  \raise Exception("Not Implemented!"):call BackwardMarker(9)
"}}}
" Conftest File{{{
inoremap <buffer> <leader>dh """<++>"""
  \import pytest
  \@pytest.fixturedef <++>() -> <++>:
  \"""<++>"""<++>
  \:call BackwardMarker(5)
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
