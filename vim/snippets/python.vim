" Python {{{
" File {{{
inoremap <buffer> <leader>pf """
      \<++>
      \"""
      \import logging
      \logger = logging.getLogger(__name__)
      \<++>
      \if __name__ == "__main__":
      \pass:call bushels#backward_marker(2)
" }}}
" }}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd def <++>(<++>):<++><++><<:call bushels#backward_marker(4)
"}}}
" Argument {{{
inoremap <buffer> <leader>fa <++>, <++>:call bushels#backward_marker(2)
"}}}
" Inline {{{
inoremap <buffer> <leader>fi lambda <++>: <++>:call bushels#backward_marker(2)
"}}}
"}}}

" Variable {{{
" Definition {{{
inoremap <buffer> <leader>vd <++> = <++><++>:call bushels#backward_marker(3)
" }}}
" Attribute {{{
inoremap <buffer> <leader>va self.<++> = <++><++>:call bushels#backward_marker(3)
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
            \plt.close():call bushels#backward_marker(7)
" }}}
" Object {{{
inoremap <buffer> <leader>po plt.<++>(
            \<++>,
            \label=<++>,
            \color=<++>,
            \)
            \<++>:call bushels#backward_marker(5)
" }}}
" }}}
"
" Class {{{
" Definition {{{
inoremap <buffer> <leader>cd class <++>:<++><++><<:call bushels#backward_marker(3)
"}}}
" Attribute {{{
inoremap <buffer> <leader>ca self.
"}}}
"}}}

" Logging {{{
" Format {{{
inoremap <buffer> <leader>lf pformat(<++>)<++>:call bushels#backward_marker()
" Info {{{
inoremap <buffer> <leader>li logger.info(<++>)<++>:call bushels#backward_marker(2)
"}}}
" Timestamps {{{
inoremap <buffer> <leader>lt logger.debug(f"Start <++>...")
      \start = time()
      \end = time()
      \logger.debug(f"Done <++>. {end - start} s"):call bushels#backward_marker(2)
"}}}
" Warning {{{
inoremap <buffer> <leader>lw logger.warning(<++>)<++>:call bushels#backward_marker(2)
"}}}
" Error {{{
"}}}
inoremap <buffer> <leader>le logger.error(<++>)<++>:call bushels#backward_marker(2)
"}}}
" Debug {{{
inoremap <buffer> <leader>ld logger.debug(<++>)<++>:call bushels#backward_marker(2)
"}}}
" Print {{{
inoremap <buffer> <leader>ll print(<++>)<++>:call bushels#backward_marker(2)
"}}}
" Breakpoint {{{
inoremap <buffer> <leader>lb print(dict(
      \file = "%",
      \line = =line("."),
      \<++>
      \));:call bushels#backward_marker(1)
" )}}
"}}}
" }}}

" Object {{{
" Identifier {{{
inoremap <buffer> <leader>oi __<++>__<++>:call bushels#backward_marker(2)
"}}}
" Method {{{
inoremap <buffer> <leader>om def __<++>__(self, <++>):<++><++><<$:call bushels#backward_marker(4)
"}}}
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,<++>:call bushels#backward_marker(3)
"}}}
"}}}

" Import {{{
" Named {{{
inoremap <buffer> <leader>in from <++> import <++>:call bushels#backward_marker(2)
"}}}
" Module {{{
inoremap <buffer> <leader>im import <++> <++>:call bushels#backward_marker(2)
"}}}
"}}}

" GraphQL {{{
" ResolveInfo {{{
inoremap <buffer> <leader>qri from graphql.execution.base import ResolveInfo
  \<++>:call bushels#backward_marker(1)
" }}}
" Resolver {{{
inoremap <buffer> <leader>qr ?classn:nohwyw2i	@staticmethod
  \def resolve_<++>(_parent: """, _info: ResolveInfo<++>) -> <++>:
  \<++>:call bushels#backward_marker(4)
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
  \<++>:call bushels#backward_marker(10)
" }}}
" }}}

" Arguments{{{
" Named {{{
inoremap <buffer> <leader>an <++>=<++>,<++>:call bushels#backward_marker(3)
" }}}
" Typed {{{
inoremap <buffer> <leader>at <++>: <++>,<++>:call bushels#backward_marker(3)
" }}}
"}}}

" Control Statements{{{
" With{{{
inoremap <buffer> <leader>cwi with <++>:<++><++><<:call bushels#backward_marker(3)
"}}}
" If {{{
" Statement {{{
inoremap <buffer> <leader>ci if <++>:<++><++><<:call bushels#backward_marker(3)
"}}}
" Else {{{
inoremap <buffer> <leader>ce else:<++><++><<:call bushels#backward_marker(2)
"}}}
" Elif {{{
inoremap <buffer> <leader>cei elif <++>:<++><++><<:call bushels#backward_marker(3)
"}}}
" Ternary {{{
inoremap <buffer> <leader>ct <++> if <++> else <++>:call bushels#backward_marker(3)
" }}}
" }}}
" Try {{{
inoremap <buffer> <leader>ct try:
  \<++>
  \except <++>:
  \<++>
  \<++><<:call bushels#backward_marker(3)
" }}}
" For {{{
" Each {{{
inoremap <buffer> <leader>cfe for <++> in <++>:
      \<++>
      \<++><<:call bushels#backward_marker(4)
" }}}
" }}}
" Index {{{
inoremap <buffer> <leader>cfo for <++> in range(<++>):
      \<++>
      \<++><<:call bushels#backward_marker(4)
" }}}
" Index {{{
inoremap <buffer> <leader>cfi for <++> in <++>:call bushels#backward_marker(2)
" }}}
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
  \<++>:call bushels#backward_marker(5)
" }}}
" Column {{{
inoremap <buffer> <leader>mc <++> = Column(<++>)
  \<++>:call bushels#backward_marker(3)
" }}}
" Primary Key {{{
inoremap <buffer> <leader>mp __table_args__ = (
      \PrimaryKeyConstraint("<++>", "<++>", name="<++>"),
      \)
      \<++>:call bushels#backward_marker(4)
" }}}
" }}}
