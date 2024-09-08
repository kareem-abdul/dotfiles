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

return M;
