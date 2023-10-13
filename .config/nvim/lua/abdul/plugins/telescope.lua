return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'kareem-abdul/harpoon',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local mappings = require("abdul.core.remap").telescope_keymaps();
        require("telescope").setup({
            defaults = {
                mappings = mappings,
                path_diplay = { shorten = 3 },
                sorting_strategy = "ascending",
                layout_config = {
                    -- height = 0.99,
                    width = 0.95,
                    prompt_position = 'top',
                    preview_width = 0.45,
                }
            }
        })
        require('telescope').load_extension('fzf')
        require("telescope").load_extension('harpoon')
    end

}
