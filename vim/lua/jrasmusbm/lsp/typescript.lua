local M = {}

function M.setup(options)
    require('lspconfig').tsserver.setup {
        on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            options.on_attach(client)

        end
    }
end

return M
