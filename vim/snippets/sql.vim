" New{{{
inoremap <buffer> <leader>bnt CREATE TABLE <++> (<++>);<++>:call bushels#backward_marker(3)
inoremap <buffer> <leader>bnc ADD COLUMN <++>,<++>:call bushels#backward_marker(2)
inoremap <buffer> <leader>bne CREATE TYPE <++> AS ENUM	(<++>);<++><<:call bushels#backward_marker(2)
inoremap <buffer> <leader>bns CREATE SEQUENCE <++>;<++>:call bushels#backward_marker(2)
"}}}
" Drop{{{
inoremap <buffer> <leader>bdc DROP COLUMN <++>:call bushels#backward_marker(1)
inoremap <buffer> <leader>bdt DROP TABLE <++>;:call bushels#backward_marker(1)
"}}}
" Alter{{{
inoremap <buffer> <leader>bat ALTER TABLE  <++>  <++>; <++><<$:call bushels#backward_marker(3)
"}}}
" Types{{{
inoremap <buffer> <leader>bts VARCHAR(<++>)<++>:call bushels#backward_marker(2)
inoremap <buffer> <leader>bta SERIAL<++>:call bushels#backward_marker(1)
inoremap <buffer> <leader>bti INTEGER<++>:call bushels#backward_marker(1)
inoremap <buffer> <leader>btf FLOAT<++>:call bushels#backward_marker(1)
inoremap <buffer> <leader>btb BOOLEAN<++>:call bushels#backward_marker(1)
"}}}
" Constraints{{{
inoremap <buffer> <leader>bcf FOREIGN KEY (<++>) REFERENCES <++> (<++>),<++>:call bushels#backward_marker(4)
inoremap <buffer> <leader>bcp CONSTRAINT <++> PRIMARY KEY (<++>),<++>:call bushels#backward_marker(3)
inoremap <buffer> <leader>bcr NOT NULL<++>:call bushels#backward_marker(1)
inoremap <buffer> <leader>bcu UNIQUE<++>:call bushels#backward_marker(1)
"}}}
" Query{{{
" INSERT {{{
inoremap <buffer> <leader>bqi INSERT INTO <++> (<++>) VALUES (<++>);:call bushels#backward_marker(3)
"}}}
" SELECT {{{
inoremap <buffer> <leader>bqs SELECT <++> FROM <++>:call bushels#backward_marker(2)
" }}}
" WHERE {{{
inoremap <buffer> <leader>bqw WHERE <++>:call bushels#backward_marker(1)
" }}}
" GROUPBY {{{
inoremap <buffer> <leader>bqg GROUP BY <++>:call bushels#backward_marker(1)
" }}}
"}}}
