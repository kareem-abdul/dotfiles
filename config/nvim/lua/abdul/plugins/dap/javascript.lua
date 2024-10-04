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

dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
    },
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file with node args",
        program="${file}",
        cwd="${workspaceFolder}",
        console="integratedTerminal",
        runtimeArgs = function ()
            local co = coroutine.running()
            vim.ui.input({ prompt = "node args"}, function (input)
                coroutine.resume(co, input or "")
            end)

            local input = coroutine.yield();
            return { input }
        end
    },
    {
        type = "pwa-node",
        request = "attach",
        port = 9229,
        name = "Attach",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
    },
}

