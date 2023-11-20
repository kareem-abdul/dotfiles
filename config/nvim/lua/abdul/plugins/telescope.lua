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
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                },
                file_ignore_patterns = { ".git", "node_modules" },
                mappings = mappings,
                path_diplay = { shorten = 3 },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        width = 0.95,
                        prompt_position = 'top',
                        preview_width = 0.45,
                    }
                }
            }
        })
        require('telescope').load_extension('fzf')
        require("telescope").load_extension('harpoon')
    end

}
