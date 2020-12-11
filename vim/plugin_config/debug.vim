packadd! vimspector

nnoremap <leader>ii :call vimspector#Launch()
nnoremap <leader>ir :call vimspector#Restart()
nnoremap <leader>ip :call vimspector#Pause()
nnoremap <leader>ic :call vimspector#RunToCursor()
nnoremap <leader>if :call vimspector#StepInto()
nnoremap <leader>ia :call vimspector#StepOut()
nnoremap <leader>id :call vimspector#StepOver()
nnoremap <leader>iq :call vimspector#Stop()
