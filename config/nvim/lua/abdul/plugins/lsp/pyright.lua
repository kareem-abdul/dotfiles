local lspconfig = require("lspconfig")

local M = {};

function M.setup(capabilities, on_attach)
    lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach =  on_attach,
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

