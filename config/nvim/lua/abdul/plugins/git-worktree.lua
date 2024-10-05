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
            update_on_change_command = 'e .',
            clearjumps_on_change = true,
            confirm_telescope_deletions = true,
            autopush = false,
        }
        require('abdul.core.remap').git_worktree_keymaps()
    end
}
