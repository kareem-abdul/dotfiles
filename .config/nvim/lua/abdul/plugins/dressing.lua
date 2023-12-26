return {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    config = function()
        require('dressing')
            .setup({
                input = {
                    enabled = true,
                    default_prompt = "Input:",
                    title_pos = "left",
                    insert_only = true,
                    start_in_insert = true,
                    border = "rounded",
                    relative = "editor",
                    win_options = {
                        winblend = 10,
                        wrap = false,
                        list = true,
                        listchars = "precedes:…,extends:…",
                        sidescrolloff = 0,
                    },

                    mappings = {
                        n = {
                            ["<Esc>"] = "Close",
                            ["<CR>"] = "Confirm",
                        },
                        i = {
                            ["<C-c>"] = "Close",
                            ["<CR>"] = "Confirm",
                            ["<C-k>"] = "HistoryPrev",
                            ["<C-j>"] = "HistoryNext",
                        },
                    },

                },
                select = {
                    enabled = true,
                    backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
                    trim_prompt = true,
                    telescope = require 'telescope.themes'.get_dropdown({
                        layout_config = {
                            width = function(_, max_columns)
                                local percentage = 0.5
                                return math.floor(percentage * max_columns)
                            end,
                        },
                    })
                },
            })
    end

}
