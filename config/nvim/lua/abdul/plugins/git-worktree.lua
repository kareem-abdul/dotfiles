return {
    "polarmutex/git-worktree.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    enable = function()
        return vim.fs.find(".git", { upward = true, path = vim.fn.getcwd() })[1] ~= nil
    end,
    lazy = false,
    config = function()
        -- vim.g.git_worktree_log_level = 'trace'
        vim.g.git_worktree = {
            change_directory_command = 'cd',
            update_on_change = true,
            update_on_change_command = 'Oil .',
            clearjumps_on_change = true,
            confirm_telescope_deletions = true,
            autopush = false,
        }
        local Hooks = require("git-worktree.hooks")
        Hooks.register(Hooks.type.SWITCH, Hooks.builtins.update_current_buffer_on_switch)
        require('abdul.core.remap').git_worktree_keymaps()
    end
}
