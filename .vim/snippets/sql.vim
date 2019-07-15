inoremap <buffer> <leader>td CREATE TABLE <++> (<++>);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>dt DROP TABLE <++>;:call BackwardMarker(1)
inoremap <buffer> <leader>tu ALTER TABLE  <++>  <++>; <++><<$:call BackwardMarker(3)
inoremap <buffer> <leader>cd ADD COLUMN <++>:call BackwardMarker(1)
inoremap <buffer> <leader>dc DROP COLUMN <++>:call BackwardMarker(1)
inoremap <buffer> <leader>fk FOREIGN KEY (<++>) REFERENCES <++> (<++>)<++>:call BackwardMarker(4)
inoremap <buffer> <leader>in INSERT INTO <++> (<++>) VALUES (<++>);:call BackwardMarker(3)
