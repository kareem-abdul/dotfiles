local M = {};

function M.load(name)
    local status, module = pcall(require, name)
    if status then
        return module
    end
    return nil
end

function M.removeQfLine()
    local curqfidx = vim.fn.line('.') - 1
    local qfall = vim.fn.getqflist();
    if not qfall or #qfall == 0 then
        return
    end
    table.remove(qfall, curqfidx)
    vim.fn.setqflist(qfall, 'r')

    -- local new_idx = curqfidx < #qfall and curqfidx or math.max(curqfidx, 1)
    --
    -- local winid = vim.fn.win_getid()
    -- vim.api.nvim_win_set_cursor(winid, { new_idx, 0 })
end

-- saves breakpoints
M.store_breakpoints = function(clear)
    local CACHE = vim.fn.stdpath('cache');
    -- if doesn't exist create it:
    if vim.fn.filereadable(CACHE .. "/dap/breakpoints.json") == 0 then
        -- Create file
        os.execute("mkdir -p " .. CACHE .. "/dap")
        os.execute("touch " .. CACHE .. "/dap/breakpoints.json")
    end

    local load_bps_raw = io.open(CACHE .. "/dap/breakpoints.json", "r"):read "*a"
    if load_bps_raw == "" then
        load_bps_raw = "{}"
    end

    local bps = vim.fn.json_decode(load_bps_raw)
    local breakpoints_by_buf = require("dap.breakpoints").get()
    if clear then
        for _, bufrn in ipairs(vim.api.nvim_list_bufs()) do
            local file_path = vim.api.nvim_buf_get_name(bufrn)
            if bps[file_path] ~= nil then
                bps[file_path] = {}
            end
        end
    else
        for buf, buf_bps in pairs(breakpoints_by_buf) do
            bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
        end
    end
    local fp = io.open(CACHE .. "/dap/breakpoints.json", "w")
    local final = vim.fn.json_encode(bps)
    fp:write(final)
    fp:close()
end

M.load_breakpoints = function()
    local CACHE = vim.fn.stdpath('cache');
    local fp = io.open(CACHE .. "/dap/breakpoints.json", "r")
    if fp == nil then
        print "No breakpoints found."
        return
    end
    local content = fp:read "*a"
    local bps = vim.fn.json_decode(content)
    local loaded_buffers = {}
    local found = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local file_name = vim.api.nvim_buf_get_name(buf)
        if bps[file_name] ~= nil and bps[file_name] ~= {} then
            found = true
        end
        loaded_buffers[file_name] = buf
    end
    if found == false then
        return
    end
    for path, buf_bps in pairs(bps) do
        for _, bp in pairs(buf_bps) do
            local line = bp.line
            local opts = {
                condition = bp.condition,
                log_message = bp.logMessage,
                hit_condition = bp.hitCondition,
            }
            require("dap.breakpoints").set(opts, tonumber(loaded_buffers[path]), line)
        end
    end
end

return M;
