local M = {}

local lspconfig = require('lspconfig')

function M.setup(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", 'templ', 'handlebars', 'hbs' },
        init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
                css = true,
                javascript = true
            },
            provideFormatter = true,
        }

    })
end

return M
