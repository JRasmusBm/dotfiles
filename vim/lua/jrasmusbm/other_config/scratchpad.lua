vim.cmd [[
command! Scratchpad e ~/.scratchpad

augroup Scratchpad
  autocmd BufRead .scratchpad call jrasmusbm#scratchpad#start()
augroup END
]]
