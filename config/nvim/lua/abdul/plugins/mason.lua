return {
    "williamboman/mason.nvim",
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim'
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

        require('mason-tool-installer').setup({
            ensure_installed = {
                "yq",
                "java-test",
                "java-debug-adapter"
            },
            run_on_start = true
        });
        require('mason-lspconfig').setup({
            ensure_installed = {
                "dockerls",
                "eslint",
                "jsonls",
                "tsserver",
                "lua_ls",
                "jdtls",    -- eclipse java lsp
                "marksman", -- markdown lsp
                "spectral", -- openapi lsp server
            },
            automatic_installation = true,
        });
    end
}
