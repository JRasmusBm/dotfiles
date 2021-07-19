packadd! nvim-dap

nnoremap <leader>ii :lua require('dap').launch()
nnoremap <leader>is :lua require('dap').stop()
nnoremap <leader>in :lua require('dap').continue()
nnoremap <leader>ih :lua require('dap').step_back()
nnoremap <leader>ij :lua require('dap').step_into()
nnoremap <leader>ik :lua require('dap').step_out()
nnoremap <leader>il :lua require('dap').step_over()
nnoremap <leader>iL :lua require('dap').run_last()
nnoremap <leader>io :lua require('dap').repl.open()
nnoremap <leader>ib :lua require('dap').toggle_breakpoint()
nnoremap <leader>iB :lua require('dap').list_breakpoints()
