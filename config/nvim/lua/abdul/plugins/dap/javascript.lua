local dap = require("dap")

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

dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
    },
}


