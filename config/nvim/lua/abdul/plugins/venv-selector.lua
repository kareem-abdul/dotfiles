-- manages activates venv on running neovim instances
return {
    "linux-cultist/venv-selector.nvim",
    lazy = true,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function()
        require("venv-selector").setup({
            settings = {
                options = {
                    debug = false,
                    fd_binary_name = "find",
                    enable_default_searches = false, -- requires fd command to be installed https://github.com/sharkdp/fd
                    notify_user_on_venv_activation = false,
                },
                search = {
                    my_venv = {
                        command = "$FD " .. vim.fn.getcwd() .. " -name python"
                    }
                },
            }
        })
    end,
    cmd = {
        "VenvSelect"
    },
};
