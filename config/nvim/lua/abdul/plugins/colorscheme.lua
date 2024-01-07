

return {
    -- { 'rose-pine/neovim', name = "rose-pine", lazy = false, priority=1000, config = function() vim.cmd.colorscheme("rose-pine") end},
    { 
        "catppuccin/nvim", 
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                term_colors = true,
            })
            vim.cmd.colorscheme("catppuccin")
        end
    },
}
