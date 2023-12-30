return    {
    "williamboman/mason.nvim",
    dependencies = {
        'williamboman/mason-lspconfig.nvim'
    },
    config = function()
        require('mason').setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            registries = {
                "file:" .. vim.fn.stdpath('config'),
                "github:mason-org/mason-registry"
            }
        });
        require('mason-lspconfig').setup({
            ensure_installed = {
                "dockerls",
                "eslint",
                "jsonls",
                "tsserver",
                "lua_ls",
                "jdtls", -- eclipse java lsp
                "marksman", -- markdown lsp 
                "spectral", -- openapi lsp server
            },
            automatic_installation = true,
        });
    end
}

