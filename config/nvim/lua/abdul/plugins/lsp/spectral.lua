local M = {}

local lspconfig = require('lspconfig')

function M.setup(capabilities)
    local default_config = require('lspconfig.server_configurations.spectral').default_config;
    lspconfig.spectral.setup(
        vim.tbl_deep_extend('force', default_config, {
            capabilities = capabilities,
            filetypes = { 'yaml', 'yml' },
            settings = {
                validateLanguages = { 'yaml', 'yml' },
            }
        })

    )
end

return M
