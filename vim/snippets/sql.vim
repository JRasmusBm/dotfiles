" New{{{
inoremap <buffer> <leader>nt CREATE TABLE <++> (<++>);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>nc ADD COLUMN <++>,<++>:call BackwardMarker(2)
inoremap <buffer> <leader>ne CREATE TYPE <++> AS ENUM	(<++>);<++><<:call BackwardMarker(2)
inoremap <buffer> <leader>ns CREATE SEQUENCE <++>;<++>:call BackwardMarker(2)
"}}}
" Drop{{{
inoremap <buffer> <leader>dc DROP COLUMN <++>:call BackwardMarker(1)
inoremap <buffer> <leader>dt DROP TABLE <++>;:call BackwardMarker(1)
"}}}
" Alter{{{
inoremap <buffer> <leader>at ALTER TABLE  <++>  <++>; <++><<$:call BackwardMarker(3)
"}}}
" Types{{{
inoremap <buffer> <leader>ts VARCHAR(<++>)<++>:call BackwardMarker(2)
inoremap <buffer> <leader>ta SERIAL<++>:call BackwardMarker(1)
inoremap <buffer> <leader>ti INTEGER<++>:call BackwardMarker(1)
inoremap <buffer> <leader>tf FLOAT<++>:call BackwardMarker(1)
inoremap <buffer> <leader>tb BOOLEAN<++>:call BackwardMarker(1)
"}}}
" Constraints{{{
inoremap <buffer> <leader>cf FOREIGN KEY (<++>) REFERENCES <++> (<++>),<++>:call BackwardMarker(4)
inoremap <buffer> <leader>cp CONSTRAINT <++> PRIMARY KEY (<++>),<++>:call BackwardMarker(3)
inoremap <buffer> <leader>cr NOT NULL<++>:call BackwardMarker(1)
inoremap <buffer> <leader>cu UNIQUE<++>:call BackwardMarker(1)
"}}}
" Query{{{
inoremap <buffer> <leader>in INSERT INTO <++> (<++>) VALUES (<++>);:call BackwardMarker(3)
"}}}
