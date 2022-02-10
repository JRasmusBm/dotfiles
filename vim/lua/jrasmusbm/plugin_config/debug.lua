local mappings = require("jrasmusbm.utils.mappings")

vim.cmd [[
packadd! nvim-dap
packadd! nvim-dap-python
]]

mappings.nmap("<leader>i<Enter>", "<cmd>lua require('dap').continue()<cr>",
              {noremap = true})
mappings.nmap("<leader>i<Esc>", "<cmd>lua require('dap').disconnect()<cr>",
              {noremap = true})
mappings.nmap("<leader>ih", "<cmd>lua require('dap').step_back()<cr>",
              {noremap = true})
mappings.nmap("<leader>il", "<cmd>lua require('dap').step_into()<cr>",
              {noremap = true})
mappings.nmap("<leader>ij", "<cmd>lua require('dap').step_out()<cr>",
              {noremap = true})
mappings.nmap("<leader>ik", "<cmd>lua require('dap').step_over()<cr>",
              {noremap = true})
mappings.nmap("<leader>ir", "<cmd>lua require('dap').run_last()<cr>",
              {noremap = true})
mappings.nmap("<leader>ip", "<cmd>lua require('dap').repl.open()<cr>",
              {noremap = true})
mappings.nmap("<leader>i<Space>", "<cmd>lua require('dap').toggle_breakpoint()<cr>",
              {})
mappings.nmap("<leader>iq", "<cmd>lua require('dap').list_breakpoints()<cr>",
              {noremap = true})
