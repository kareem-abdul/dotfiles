local dap = require("dap")

dap.adapters.nlua = function(callback, config)
    ---@diagnostic disable-next-line: undefined-field
    local host = config.host or "127.0.0.1"
    ---@diagnostic disable-next-line: undefined-field
    local port = config.port or 8086
    callback({ type = 'server', host = host, port = port })
end

dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
    }
}

-- vim.keymap.set("n", "<leader>F5", function()
--     require("osv").launch({ port = 8086 })
-- end)
