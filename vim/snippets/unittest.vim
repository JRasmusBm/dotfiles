" Suite {{{
inoremap <buffer> <leader>ds class Test<++>:
" }}}

" Case {{{
inoremap <buffer> <leader>dc def test_<++>(self, <++>) -> None:
      \raise Exception("Not Implemented!")
      \<++><<:call bushels#backward_marker(3)
" }}}

" Before Each {{{
inoremap <buffer> <leader>db @pytest.fixture
  \def <++>() -> <++>:
  \<++>
" }}}

" Expect {{{
inoremap <buffer> <leader>de assert <++>
" Raises {{{
inoremap <buffer> <leader>der with self.assertRaisesRegex(<++>, "<++>"):
      \<++>:call bushels#backward_marker(3)
"}}}
" }}}

" Test File {{{
inoremap <buffer> <leader>df """
  \import pytest
  \@pytest.fixture
  \"""
  \class Test<++>:<<A
  \def test_<++>(self,<++>) -> None:
  \raise Exception("Not Implemented!"):call bushels#backward_marker(9)
"}}}

" Conftest File{{{
inoremap <buffer> <leader>dh """
  \import pytest
  \@pytest.fixture
  \"""
  \:call bushels#backward_marker(5)
"}}}