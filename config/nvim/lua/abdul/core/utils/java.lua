local M = {}

--- Gets the full qualified name of a class
---@param bufnr integer buffer number
---@param fn string|nil the file name
---@return string
function M.canonical_name(bufnr, fn)
    local fileType = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    if fileType ~= "java" then
        return ""
    end

    local language_tree = vim.treesitter.get_parser(bufnr, "java")
    local syntax_tree = language_tree:trees()
    local root = syntax_tree[1]:root()

    local query = vim.treesitter.query.parse("java", [[
        (package_declaration
            (scoped_identifier) @package)
    ]])

    local package = ""
    for _, capture, _ in query:iter_captures(root, bufnr) do
        package = vim.treesitter.get_node_text(capture, bufnr)
    end

    local file_name = fn
    if file_name == nil then
        file_name = vim.api.nvim_buf_get_name(bufnr)
    end

    if vim.startswith(file_name, "jdt://") then
        local lastIndex = string.find(file_name, "%.class?") - 1
        local firstIndex = string.find(string.sub(file_name, 0, lastIndex), "/[^/]*$") + 1
        local class_name = string.sub(file_name, firstIndex, lastIndex)
        return package and (package .. "." .. class_name) or class_name
    end

    local lastIndex = string.find(file_name, "%.java$") - 1
    local firstIndex = string.find(file_name, "/[^/]*$") + 1
    local class_name =  string.sub(file_name, firstIndex, lastIndex)
    return package and (package .. "." .. class_name) or class_name
end


return M

