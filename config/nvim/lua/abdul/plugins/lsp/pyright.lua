local lspconfig = require("lspconfig")

local M = {};

function M.setup(capabilities)
    lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
            pyright = {
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    ignore = { '*' } -- ruff_lsp handles all formatting and linting
                }
            }
        }
    })
end

return M;

