local function setup_signs()
    local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type;
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl });
    end
end

local function setup_autocommands()
    local lsp_attach_group = vim.api.nvim_create_augroup("nvim-lsp-attach", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_attach_group,
        callback = function(event)
            local bufnr = event.buf;
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            require("abdul.core.remap").lsp_config_keymaps(client, bufnr)
            if client and client.server_capabilities.documentHighlightProvider then
                local highlight_augroup = vim.api.nvim_create_augroup("nvim-lsp-highlight-group", { clear = true })

                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    buffer = bufnr,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight
                })

                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    buffer = bufnr,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references
                })

                vim.api.nvim_create_autocmd("LspDetach", {
                    buffer = bufnr,
                    group = vim.api.nvim_create_augroup("nvim-lsp-dettach", { clear = true }),
                    callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds({
                            group = "nvim-lsp-highlight-group",
                            buffer = event2.buf
                        })
                    end
                })
            end
        end
    })
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        { 'j-hui/fidget.nvim', opts = {} },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require('lspconfig');
        local utils = require("abdul.core.utils");

        setup_signs();
        setup_autocommands()

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )
        -- local capabilities = require('cmp_nvim_lsp').default_capabilities();
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                if server_name == 'jdtls' then
                    return
                end
                local server_setup = utils.load("abdul.plugins.lsp." .. server_name);
                if server_setup then
                    server_setup.setup(capabilities);
                    return;
                end
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                });
            end,
        })
        require("ufo");
    end
}
