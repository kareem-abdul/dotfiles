local lspconfig = require("lspconfig")
local remap = require("abdul.core.remap")

local M = {};

function M.setup(capabilities)
    lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function (client, bufnr)
            remap.eslint_lsp_keymaps(bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end
    })
end

return M;

