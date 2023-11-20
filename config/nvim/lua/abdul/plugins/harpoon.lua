return {
    'kareem-abdul/harpoon',
    -- dir = "/home/kareem/workspace/scripts/plugins/nvim/harpoon",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        -- vim.g.harpoon_log_level = "trace"
        require("harpoon").setup({
            global_settings = {
                tabline = true,
                send_commands_to_tmux_window = true,
            },
        });

        require("abdul.core.remap").harpoon_keymaps();

        vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
        vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
        vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
        vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
        vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
    end
}
