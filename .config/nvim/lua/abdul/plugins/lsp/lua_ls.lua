
local lspconfig = require("lspconfig");
local M = {};

function M.setup(capabilities, on_attach)
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

end

return M

