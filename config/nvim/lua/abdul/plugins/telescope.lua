return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-dap.nvim',
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

        local function filenameFirst(_, path)
            local tail = vim.fs.basename(path)
            local parent = vim.fs.dirname(path)
            if parent == "." then return tail end
            return string.format("%s\t-\t%s", tail, parent)
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "TelescopeResults",
            callback = function(ctx)
                vim.api.nvim_buf_call(ctx.buf, function()
                    vim.fn.matchadd("TelescopeParent", "\t-\t.*$")
                    vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
                end)
            end,
        })

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
                path_display =  filenameFirst,
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
        require("telescope").load_extension('dap')
    end

}
