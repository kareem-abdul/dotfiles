local dap = require("dap")

if not dap.adapters["pwa-node"] then
    local debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter'
    dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = debugger_path .. "/js-debug-adapter",
            args = { "${port}" }
        }
    }
end

local ts_loader = vim.fn.stdpath('data') .. '/mason/packages/ts-node/node_modules/ts-node/esm.mjs'
dap.configurations.typescript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeArgs = { '--loader=' .. ts_loader },
        sourceMaps = true,
        protocol = 'inspector',
        outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
        skipFiles = { '<node_internals>/**', 'node_modules/**' },
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
        console = "integratedTerminal",

    },

}
