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

                "ruff_lsp",
                "debugpy"
            },
            run_on_start = true
        });
        require('mason-lspconfig').setup({
            ensure_installed = {
                "tsserver", -- javascript, typescript lsp
                "pyright", -- python lsp
                "jdtls", -- eclipse java lsp
                "lua_ls", -- lua lsp
                "html",
                "cssls",
                "tailwindcss",
                "dockerls",
                "eslint",
                "jsonls",
                "marksman", -- markdown lsp
                "spectral", -- openapi lsp server
                "solidity_ls"
            },
            automatic_installation = true,
        });
    end
}
