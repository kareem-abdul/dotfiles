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

function M.filename()
    local fn = vim.fn.expand('%:~:.')
    if vim.bo.filetype == "java" then
        fn = require("abdul.core.utils.java").canonical_name(0, fn)
    end
    if fn == '' then
        fn = '[No Name]'
    end
    if vim.bo.modified then
        fn = fn .. ' [+]'
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
        fn = fn .. ' [readonly]'
    end
    local tfn = vim.fn.expand('%')
    if tfn ~= '' and vim.bo.buftype == '' and vim.fn.filereadable(tfn) == 0 then
        fn = fn .. ' [New]'
    end
    return fn
end

function M.string_trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ''
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
        end
        return str
    end
end

function M.buffer_not_empty()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

function M.split_string(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function M.load_env_file(file)
    local fd = io.open(file, 'r')
    if fd == nil then
        return {}
    end

    ---@type string
    local content = fd:read('*a')
    local envs = {}
    local _ = content:gsub('(.-)\r?\n', function(line)
        if not (line == nil or line == '') and string.sub(line, 1, 1) ~= '#' then
            local index = string.find(line, "=")
            local key = string.sub(line, 1, index - 1)
            local raw_value = string.sub(line, index + 1)
            local value = raw_value and vim.trim(raw_value) or ''
            vim.fn.setenv(key, value)
            envs[key] = value
        end
    end)
    fd:close()
    return envs
end

return M;
