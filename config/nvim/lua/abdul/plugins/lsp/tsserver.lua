local lspconfig = require('lspconfig');

local organise_imports = function ()
    local params = {
        command = '_typescript.organizeImports',
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = '',
    };
    vim.lsp.buf.execute_command(params);
end

local M = {};

function M.setup(capabilities)
    lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
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
    });
end

return M;
