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
        local form_entry = require("telescope.from_entry")
        local f_path = form_entry.path
        form_entry.path = function(entry, validate, escape)
            if entry.filename and vim.startswith(entry.filename, "jdt://") then
                return entry.filename
            end
            return f_path(entry, validate, escape)
        end

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
                mappings = require("abdul.core.remap").telescope_keymaps(),
                path_diplay = { shorten = 3 },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        width = 0.95,
                        prompt_position = 'top',
                        preview_width = 0.45,
                    }
                },
                preview = {
                    filetype_hook = function(filepath, bufnr, opts)
                        if vim.startswith(filepath, "jdt://") then
                            vim.api.nvim_buf_call(bufnr, function() require("jdtls").open_classfile(filepath) end)
                            return true
                        end
                        return true
                    end,
                }
            }
        })
        require('telescope').load_extension('fzf')
        require("telescope").load_extension('harpoon')
    end

}
