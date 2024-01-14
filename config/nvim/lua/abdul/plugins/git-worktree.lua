return {
    "polarmutex/git-worktree.nvim",
    enable = function()
        return vim.fs.find(".git", { upward = true, path = vim.fn.getcwd() })[1] ~= nil
    end,
    lazy = false,
    config = function()
        local worktree = require("git-worktree")
        worktree.setup({
            update_on_change = true,
            clearjumps_on_change = true,
            autopush = false,
            update_on_change_command = "Oil ."
        })
        require('abdul.core.remap').git_worktree_keymaps()
    end
}
