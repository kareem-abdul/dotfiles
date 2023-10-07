local M = {};

function M.load(name) 
    local status,module =  pcall(require, name)
    if status then
        return module
    end
    return nil
end

return M;
