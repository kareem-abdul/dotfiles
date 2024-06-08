local lspconfig = require("lspconfig")

local M = {};

function M.setup(capabilities)
    lspconfig.solidity_ls.setup({
        capabilities = capabilities,
        cmd = {
            vim.fn.stdpath('data') .. '/mason/packages/vscode-solidity-server/node_modules/vscode-solidity-server/dist/cli/server.js',
            '--stdio'
        },
        filetypes = { 'solidity' }
    });
end

return M;
