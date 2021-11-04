" Suite {{{
inoremap <buffer> <leader>ds class Test<++>(unittest.TestCase):<++><++><<:call bushels#backward_marker(3)
" }}}

" Case {{{
inoremap <buffer> <leader>dc def test_<++>(self, <++>) -> None:
      \raise Exception("Not Implemented!")
      \<++><<:call bushels#backward_marker(3)
" }}}

" Before Each {{{
inoremap <buffer> <leader>db @pytest.fixture
  \def <++>() -> <++>:
  \<++><++><<:call bushels#backward_marker(4)
" }}}

" Expect {{{
inoremap <buffer> <leader>de self.assertEqual(<++>, <++>):call bushels#backward_marker(2)
" Raises {{{
inoremap <buffer> <leader>der with self.assertRaisesRegex(<++>, "<++>"):
      \<++>:call bushels#backward_marker(3)
"}}}
" }}}

" Test File {{{
inoremap <buffer> <leader>df import unittest
  \class Test<++>(unittest.TestCase):<<A
  \def test_<++>(self) -> None:
  \raise Exception("Not Implemented!"):call bushels#backward_marker(2)
"}}}

" Conftest File{{{
inoremap <buffer> <leader>dh """<++>"""
  \import pytest
  \@pytest.fixturedef <++>() -> <++>:
  \"""<++>"""<++>
  \:call bushels#backward_marker(5)
"}}}
