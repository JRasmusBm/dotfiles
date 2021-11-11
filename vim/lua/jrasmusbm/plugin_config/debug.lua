local mappings = require("jrasmusbm.utils.mappings")

vim.cmd [[
packadd! nvim-dap
packadd! nvim-dap-python
]]

mappings.nmap("<leader>ii", "<cmd>lua require('dap').launch()<cr>",
              {noremap = true})
mappings.nmap("<leader>is", "<cmd>lua require('dap').stop()<cr>",
              {noremap = true})
mappings.nmap("<leader>in", "<cmd>lua require('dap').continue()<cr>",
              {noremap = true})
mappings.nmap("<leader>ih", "<cmd>lua require('dap').step_back()<cr>",
              {noremap = true})
mappings.nmap("<leader>ij", "<cmd>lua require('dap').step_into()<cr>",
              {noremap = true})
mappings.nmap("<leader>ik", "<cmd>lua require('dap').step_out()<cr>",
              {noremap = true})
mappings.nmap("<leader>il", "<cmd>lua require('dap').step_over()<cr>",
              {noremap = true})
mappings.nmap("<leader>iL", "<cmd>lua require('dap').run_last()<cr>",
              {noremap = true})
mappings.nmap("<leader>io", "<cmd>lua require('dap').repl.open()<cr>",
              {noremap = true})
mappings.nmap("<leader>ib", "<cmd>lua require('dap').toggle_breakpoint()<cr>",
              {})
mappings.nmap("<leader>iB", "<cmd>lua require('dap').list_breakpoints()<cr>",
              {noremap = true})
