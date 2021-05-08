command! Scratchpad e ~/.scratchpad

augroup Scratchpad
  autocmd BufRead .scratchpad set filetype=markdown.scratchpad | startinsert
augroup END
