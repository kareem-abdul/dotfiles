
local function setup_signs()
    local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type;
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl });
    end
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp'
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require('lspconfig');
        local remap = require("abdul.core.remap");
        local utils = require("abdul.core.utils");

        setup_signs();

        local on_attach = function(client, bufnr) remap.lsp_config_keymaps(client, bufnr) end;
        local capabilities = require('cmp_nvim_lsp').default_capabilities();
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                if server_name == 'jdtls' then
                    return
                end
                local server_setup = utils.load("abdul.plugins.lsp." .. server_name);
                if server_setup then
                    server_setup.setup(capabilities, on_attach);
                    return;
                end
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                });
            end,
       })
    end
}

