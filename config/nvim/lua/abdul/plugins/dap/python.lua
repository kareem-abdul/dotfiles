local dap = require('dap')

local function python_path()
    local cwd = vim.fn.getcwd()
    local path = cwd;
    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        path = cwd .. '/venv/bin/python'
    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        path =  cwd .. '/.venv/bin/python'
    else
        path =  vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
    end
    print("using " .. path);
    return path
end

local function find_manage_py()
    local path_table = vim.fs.find(
        { "manage.py" },
        {
            path = vim.fn.getcwd(),
            upward = false,
            limit = 1,
        }
    );
    return next(path_table);
end

dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'

        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python',
            },
        })
    else
        local debugger_path = vim.fn.stdpath('data') .. '/mason/packages/debugpy/debugpy-adapter'
        cb({
            type = 'executable',
            command = debugger_path,
            options = {
                source_filetype = 'python',
            },
        })
    end
end

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Python: Launch file",

        program = "${file}",
        console = "integratedTerminal",
        python = python_path,
    },
    {
        type = 'python',
        request = 'launch',
        name = 'Python: Launch Django',

        program = find_manage_py(),
        args = { 'runserver', '--noreload'},
        django = true,
        console = "integratedTerminal",
        python = python_path,
    },
    {
        type = 'python',
        request = 'attach',
        name = "Python: Attach",
        console = "integratedTerminal",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
        python = python_path,
    },
}
