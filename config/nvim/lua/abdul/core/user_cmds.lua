local previously_set = nil
local loaded_envs = {}

local function unset_loaded_env(file)
    if loaded_envs[file] == nil then
        return
    end

    local loaded_env = loaded_envs[file]
    for k, _ in pairs(loaded_env) do
        vim.fn.setenv(k, "")
    end
end

vim.api.nvim_create_user_command("Dotenv", function(opts)
    local files = vim.fn.globpath(vim.fn.getcwd(), '.env*', false, true)

    if next(files) == nil then
        vim.notify("no env files detected!!")
        return
    end

    vim.ui.select(files, {
        prompt = 'Select env file to load',
        format_item = function(item) return vim.fn.fnamemodify(item, ':~:.') end
    }, function(choice)
        if choice == nil then
            return
        end

        if previously_set ~= nil then
            unset_loaded_env(previously_set)
        end

        local envs = require('abdul.core.utils').load_env_file(choice)

        loaded_envs[choice] = envs
        previously_set = choice
        vim.notify("env loaded", vim.log.levels.INFO)
    end)
end, { desc="Loads environtment variables from a dotenv file"})

vim.api.nvim_create_user_command('T4T', function ()
    local opt = vim.opt
    opt.tabstop = 4
    opt.softtabstop = 4
    opt.shiftwidth = 4
end, { desc="sets tab width to 4 (default)"})

vim.api.nvim_create_user_command('T2T', function ()
    local opt = vim.opt
    opt.tabstop = 2
    opt.softtabstop = 2
    opt.shiftwidth = 2
end, { desc="sets tab width to 2"})
