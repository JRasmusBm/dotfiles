" New{{{
inoremap <buffer> <leader>bnt CREATE TABLE <++> (<++>);<++>:call jrasmusbm#snippets#backward_marker(3)
inoremap <buffer> <leader>bnc ADD COLUMN <++>,<++>:call jrasmusbm#snippets#backward_marker(2)
inoremap <buffer> <leader>bne CREATE TYPE <++> AS ENUM	(<++>);<++><<:call jrasmusbm#snippets#backward_marker(2)
inoremap <buffer> <leader>bns CREATE SEQUENCE <++>;<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Drop{{{
inoremap <buffer> <leader>bdc DROP COLUMN <++>:call jrasmusbm#snippets#backward_marker(1)
inoremap <buffer> <leader>bdt DROP TABLE <++>;:call jrasmusbm#snippets#backward_marker(1)
"}}}
" Alter{{{
inoremap <buffer> <leader>bat ALTER TABLE  <++>  <++>; <++><<$:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Types{{{
inoremap <buffer> <leader>bts VARCHAR(<++>)<++>:call jrasmusbm#snippets#backward_marker(2)
inoremap <buffer> <leader>bta SERIAL<++>:call jrasmusbm#snippets#backward_marker(1)
inoremap <buffer> <leader>bti INTEGER<++>:call jrasmusbm#snippets#backward_marker(1)
inoremap <buffer> <leader>btf FLOAT<++>:call jrasmusbm#snippets#backward_marker(1)
inoremap <buffer> <leader>btb BOOLEAN<++>:call jrasmusbm#snippets#backward_marker(1)
"}}}
" Constraints{{{
inoremap <buffer> <leader>bcf FOREIGN KEY (<++>) REFERENCES <++> (<++>),<++>:call jrasmusbm#snippets#backward_marker(4)
inoremap <buffer> <leader>bcp CONSTRAINT <++> PRIMARY KEY (<++>),<++>:call jrasmusbm#snippets#backward_marker(3)
inoremap <buffer> <leader>bcr NOT NULL<++>:call jrasmusbm#snippets#backward_marker(1)
inoremap <buffer> <leader>bcu UNIQUE<++>:call jrasmusbm#snippets#backward_marker(1)
"}}}
" Query{{{
" INSERT {{{
inoremap <buffer> <leader>bqi INSERT INTO <++> (<++>) VALUES (<++>);:call jrasmusbm#snippets#backward_marker(3)
"}}}
" SELECT {{{
inoremap <buffer> <leader>bqs SELECT <++> FROM <++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" WHERE {{{
inoremap <buffer> <leader>bqw WHERE <++>:call jrasmusbm#snippets#backward_marker(1)
" }}}
" GROUPBY {{{
inoremap <buffer> <leader>bqg GROUP BY <++>:call jrasmusbm#snippets#backward_marker(1)
" }}}
"}}}
