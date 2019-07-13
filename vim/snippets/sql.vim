inoremap <buffer> ;td CREATE TABLE <++> (<++>);<++>:call BackwardMarker(3)
inoremap <buffer> ;dt DROP TABLE <++>;:call BackwardMarker(1)
inoremap <buffer> ;tu ALTER TABLE  <++>  <++>; <++><<$:call BackwardMarker(3)
inoremap <buffer> ;cd ADD COLUMN <++>:call BackwardMarker(1)
inoremap <buffer> ;dc DROP COLUMN <++>:call BackwardMarker(1)
inoremap <buffer> ;fk FOREIGN KEY (<++>) REFERENCES <++> (<++>)<++>:call BackwardMarker(4)
inoremap <buffer> ;in INSERT INTO <++> (<++>) VALUES (<++>);:call BackwardMarker(3)
