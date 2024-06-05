local M = {}

local lspconfig = require('lspconfig')

function M.setup(capabilities, on_attach)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html" },
        init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
                css = true,
                javascript = true
            }
        }

    })
end

return M
