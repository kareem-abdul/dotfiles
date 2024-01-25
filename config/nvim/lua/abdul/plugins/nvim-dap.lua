
local dap_ui_layout = {
                {
                    elements = {
                        { id = "watches",     size = 0.25 },
                        { id = "breakpoints", size = 0.25 },
                        { id = "scopes",      size = 0.25 },
                        { id = "stacks",      size = 0.25 },
                    },
                    position = "left",
                    size = 40
                },
                {
                    elements = {
                        { id = "console", size = 1 },
                        -- { id = "repl", size = 0.5 }
                    },
                    position = "bottom",
                    size = 10
                }
};

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        require("abdul.core.remap").dap_keymaps()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup({
            layouts = dap_ui_layout,
            controls = {
                enabled = true,
                element = "console"
            }
        })
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

    end
}
