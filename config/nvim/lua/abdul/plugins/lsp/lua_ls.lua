local lspconfig = require("lspconfig");
local M = {};

function M.setup(capabilities)
    require("neodev")
    lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    path = vim.split(package.path, ";"),
                },
                diagnostics = {
                    globals = { "vim" }
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files and plugins
                    library = { vim.env.VIMRUNTIME },
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            }
        }
    }
end

return M
