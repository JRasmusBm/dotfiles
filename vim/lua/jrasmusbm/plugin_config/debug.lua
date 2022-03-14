local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd! nvim-dap
packadd! nvim-dap-python
packadd! nvim-dap-virtual-text
packadd! telescope-dap.nvim
packadd! debugpy.nvim
]]

mappings.nmap("<leader>i<Enter>", "<cmd>lua require('dap').continue()<cr>", { noremap = true })
mappings.nmap("<leader>i<Esc>", "<cmd>lua require('dap').disconnect()<cr>", { noremap = true })
mappings.nmap("<leader>ik", "<cmd>lua require('dap').step_back()<cr>", { noremap = true })
mappings.nmap("<leader>il", "<cmd>lua require('dap').step_into()<cr>", { noremap = true })
mappings.nmap("<leader>ih", "<cmd>lua require('dap').step_out()<cr>", { noremap = true })
mappings.nmap("<leader>ij", "<cmd>lua require('dap').step_over()<cr>", { noremap = true })
mappings.nmap("<leader>ir", "<cmd>lua require('dap').run_last()<cr>", { noremap = true })
mappings.nmap("<leader>io", "<cmd>lua require('dap').repl.open()<cr>", { noremap = true })
mappings.nmap("<leader>ib", "<cmd>lua require('dap').toggle_breakpoint()<cr>", {})
mappings.nmap("<leader>iq", "<cmd>lua require('dap').list_breakpoints()<cr>", { noremap = true })

mappings.nmap("<leader>if", "<cmd>lua require('telescope').extensions.dap.frames{}<cr>", { noremap = true })
mappings.nmap("<leader>ix", "<cmd>lua require('telescope').extensions.dap.commands{}<cr>", { noremap = true })
mappings.nmap("<leader>iv", "<cmd>lua require('telescope').extensions.dap.variables{}<cr>", { noremap = true })
mappings.nmap("<leader>ic", "<cmd>lua require('telescope').extensions.dap.configurations{}<cr>", { noremap = true })
mappings.nmap("<leader>ia", "<cmd>lua require('telescope').extensions.dap.list_breakpoints{}<cr>", { noremap = true })
