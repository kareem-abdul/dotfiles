local lspconfig = require("lspconfig")

local M = {};

function M.setup(capabilities, on_attach)
    lspconfig.solidity_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
            vim.fn.stdpath('data') .. '/mason/packages/vscode-solidity-server/node_modules/vscode-solidity-server/dist/cli/server.js',
            '--stdio'
        },
        filetypes = { 'solidity' }
    });
end

return M;
