" New{{{
inoremap <buffer> <leader>bnt CREATE TABLE <++> (<++>);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>bnc ADD COLUMN <++>,<++>:call BackwardMarker(2)
inoremap <buffer> <leader>bne CREATE TYPE <++> AS ENUM	(<++>);<++><<:call BackwardMarker(2)
inoremap <buffer> <leader>bns CREATE SEQUENCE <++>;<++>:call BackwardMarker(2)
"}}}
" Drop{{{
inoremap <buffer> <leader>bdc DROP COLUMN <++>:call BackwardMarker(1)
inoremap <buffer> <leader>bdt DROP TABLE <++>;:call BackwardMarker(1)
"}}}
" Alter{{{
inoremap <buffer> <leader>bat ALTER TABLE  <++>  <++>; <++><<$:call BackwardMarker(3)
"}}}
" Types{{{
inoremap <buffer> <leader>bts VARCHAR(<++>)<++>:call BackwardMarker(2)
inoremap <buffer> <leader>bta SERIAL<++>:call BackwardMarker(1)
inoremap <buffer> <leader>bti INTEGER<++>:call BackwardMarker(1)
inoremap <buffer> <leader>btf FLOAT<++>:call BackwardMarker(1)
inoremap <buffer> <leader>btb BOOLEAN<++>:call BackwardMarker(1)
"}}}
" Constraints{{{
inoremap <buffer> <leader>bcf FOREIGN KEY (<++>) REFERENCES <++> (<++>),<++>:call BackwardMarker(4)
inoremap <buffer> <leader>bcp CONSTRAINT <++> PRIMARY KEY (<++>),<++>:call BackwardMarker(3)
inoremap <buffer> <leader>bcr NOT NULL<++>:call BackwardMarker(1)
inoremap <buffer> <leader>bcu UNIQUE<++>:call BackwardMarker(1)
"}}}
" Query{{{
" INSERT {{{
inoremap <buffer> <leader>bqi INSERT INTO <++> (<++>) VALUES (<++>);:call BackwardMarker(3)
"}}}
" SELECT {{{
inoremap <buffer> <leader>bqs SELECT <++> FROM <++>:call BackwardMarker(2)
" }}}
" WHERE {{{
inoremap <buffer> <leader>bqw WHERE <++>:call BackwardMarker(1)
" }}}
" GROUPBY {{{
inoremap <buffer> <leader>bqg GROUP BY <++>:call BackwardMarker(1)
" }}}
"}}}
