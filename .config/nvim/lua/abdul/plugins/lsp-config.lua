return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp'
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require('lspconfig');
        local remap = require("abdul.core.remap");
        local on_attach = function(client, bufnr) remap.lsp_config_keymaps(bufnr) end
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local signs = { Error = "", Warn = "", Hint = "", "󰋼" };
        for type,icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type;
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" });
        end
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                });
            end,
            ["tsserver"] = function()
                local organise_imports = function ()
                    local params = {
                        command = '_typescript.organizeImports',
                        arguments = {vim.api.nvim_buf_get_name(0)},
                        title = '',
                    };
                    vim.lsp.buf.execute_command(params);
                end
                lspconfig.tsserver.setup({
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        on_attach(client, bufnr);
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "OrganizeImports"
                        })
                    end,
                    commands = {
                        OrganizeImports = {
                            organise_imports,
                            description = "Organize imports",
                        }
                    }
                })
            end,
            ["lua_ls"] = function ()
                lspconfig.lua_ls.setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                }
            end,
            ["eslint"] = function ()
                lspconfig.eslint.setup({
                    capabilities = capabilities,
                    on_attach = function (client, bufnr)
                        on_attach(client, bufnr)
                        remap.eslint_lsp_keymaps(bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end
                })
            end
        })

    end
}

