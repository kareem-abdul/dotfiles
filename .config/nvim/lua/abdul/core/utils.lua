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

return M;
