local CONSOLE_ONLY = 1
local WATCHER_ONLY = 2

---@type dapui.Config.layout[]
local dap_ui_layout = {};

dap_ui_layout[CONSOLE_ONLY] = {
    elements = {
        { id = "console", size = 1 }
        -- { id = "repl", size = 0.5 }
    },
    position = "bottom",
    size = 10,
}

dap_ui_layout[WATCHER_ONLY] = {
    elements = {
        { id = "watches", size = 1 },
        -- { id = "breakpoints", size = 0.25 },
        -- { id = "scopes",      size = 0.25 },
        -- { id = "stacks",      size = 0.25 },
    },
    position = "bottom",
    size = 10,
}


return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        require("abdul.core.remap").dap_keymaps({ console = CONSOLE_ONLY, watcher = WATCHER_ONLY })
        local dap, dapui = require("dap"), require("dapui")

        vim.api.nvim_create_user_command("DapLoadLaunchJSON", function ()
            require('dap.ext.vscode').load_launchjs('.dap/launch.json')
            require('dap.ext.vscode').load_launchjs('.vscode/launch.json')
        end, { nargs = 0})

        dapui.setup({
            layouts = dap_ui_layout,
            controls = {
                enabled = true,
                element = "console"
            }
        })

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.toggle({ layout = CONSOLE_ONLY })
        end
        -- dap.listeners.before.event_terminated["dapui_config"] = function()
        --     dapui.close()
        -- end
        -- dap.listeners.before.event_exited["dapui_config"] = function()
        --     dapui.close()
        -- end

        local dap_configs = vim.api.nvim_get_runtime_file("lua/abdul/plugins/dap/*.lua", true)
        for _, path in ipairs(dap_configs) do
            local file = vim.fs.basename(path)
            if not file or not vim.endswith(file, ".lua") then
                break
            end
            require("abdul.plugins.dap." .. string.gsub(file, ".lua", ""))
        end
    end
}
