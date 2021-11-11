local mappings = require("jrasmusbm.utils.mappings")

vim.cmd [[
packadd! vim-bushels
]]

mappings.imap("<leader><leader>", "<++>", {noremap = true})

mappings.imap("<leader>dd", "<Plug>BushelsDeleteMarkerRow")
mappings.nmap("<leader>dd", "<Plug>BushelsDeleteMarkerRow")

mappings.imap("<leader>dm", "<Plug>BushelsDeleteMarker")
mappings.nmap("<leader>dm", "<Plug>BushelsDeleteMarker")

mappings.imap("<leader>da", "<Plug>BushelsDeleteAllMarkers")
mappings.nmap("<leader>da", "<Plug>BushelsDeleteAllMarkers")

mappings.imap("<leader>G", "<Plug>BushelsBackwardMarker")
mappings.nmap("<leader>G", "<Plug>BushelsBackwardMarker")

mappings.imap("<leader>g", "<Plug>BushelsForwardMarker")
mappings.nmap("<leader>g", "<Plug>BushelsForwardMarker")


mappings.imap("<leader>cp",
              "<cmd>call bushels#forward_marker(1)<Enter><C-R>.<Esc><cmd>call bushels#forward_marker(1)<cr>",
              {noremap = true})
