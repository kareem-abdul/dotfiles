local lspconfig = require("lspconfig")

local M = {};

function M.setup(capabilities)
    -- https://github.com/astral-sh/ruff-lsp/issues/288
    vim.fn.setenv("RUFF_EXPERIMENTAL_FORMATTER", false);
    lspconfig.ruff_lsp.setup({
        capabilities = capabilities,
        on_attach =  function (client, buffnr)
            client.server_capabilities.hoverProvider = false
        end,
    })
end

return M;

