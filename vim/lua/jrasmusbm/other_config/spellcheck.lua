local mappings = require("jrasmusbm.utils.mappings")

mappings.nmap("<leader>ce", "<cmd>set spell spelllang+=en_us,<CR>",
              {noremap = true})
mappings.nmap("<leader>cv", "<cmd>set spell spelllang+=sv,<CR>",
              {noremap = true})
mappings.nmap("<leader>cd", "<cmd>set spell spelllang+=de,<CR>",
              {noremap = true})
mappings.nmap("<leader>cn", "<cmd>set spell spelllang+=nl,<CR>",
              {noremap = true})
mappings.nmap("<leader>ci", "<cmd>set invspell<CR>", {noremap = true})
mappings.nmap("<leader>cc", "<cmd>set spelllang=\"\"<CR>", {noremap = true})
