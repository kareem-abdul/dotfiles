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
                "java-debug-adapter",
                "ts-node",
            },
            run_on_start = true
        });
        require('mason-lspconfig').setup({
            ensure_installed = {
                "tsserver",
                "jdtls",    -- eclipse java lsp
                "html",
                "cssls",
                "tailwindcss",
                "dockerls",
                "eslint",
                "jsonls",
                "lua_ls",
                "marksman", -- markdown lsp
                "spectral", -- openapi lsp server
            },
            automatic_installation = true,
        });
    end
}
