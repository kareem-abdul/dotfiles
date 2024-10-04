local M = {}

local lspconfig = require('lspconfig')

function M.setup(capabilities)
    local default_config = require('lspconfig.server_configurations.tailwindcss').default_config;
    lspconfig.tailwindcss.setup(
        vim.tbl_deep_extend('force', default_config, {
            capabilities = capabilities,
            filetypes = {
                "django-html",
                "htmldjango",
                "ejs",
                'erb',
                'handlebars',
                'hbs',
                'eruby', -- vim ft
                "gohtml",
                "gohtmltmpl",
                "html",
                "html-eex",
                "markdown",
                "mdx",
                "mustache",
                "php",
                "css",
                "sass",
                "scss",
                "javascriptreact",
                "typescriptreact",
                "vue",
                "svelte",
                "templ"
            },
        })

    )
end

return M
