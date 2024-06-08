local lspconfig = require("lspconfig");
local M = {};

function M.setup(capabilities)
    require("neodev")
    lspconfig.lua_ls.setup {
        capabilities = capabilities,
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
