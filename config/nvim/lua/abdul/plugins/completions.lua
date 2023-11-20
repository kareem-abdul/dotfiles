return {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter" },
    dependencies = {
        -- 'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'rcarriga/cmp-dap',
        'ray-x/cmp-treesitter',
        "L3MON4D3/LuaSnip",
        'saadparwaiz1/cmp_luasnip',
        "rafamadriz/friendly-snippets"
    },
    config = function()
        local cmp = require('cmp');
        local luasnip = require('luasnip');

        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
            enabled = function()
                return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
            end,
            experimental = {
                ghost_text = true,
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert(require('abdul.core.remap').nvim_cmp_completions()),
            completion = {
                completeopt = 'menu,menuone,preview,noselect',
            },
            sources = cmp.config.sources({
                -- { name = 'buffer' },
                { name = 'treesitter' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },

                { name = 'nvim_lua' },
                { name = 'path' },
            }),
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        path = "[path]",
                        buffer = "[Buffer]",
                        treesitter = "[treesitter]"
                    })[entry.source.name]
                    return vim_item
                end
            },
        });
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }

            })
        });

        require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
            sources = {
                { name = "dap" },
                -- { name = 'treesitter' },
                -- { name = 'nvim_lsp' },
                -- { name = 'luasnip' },
                --
                -- { name = 'nvim_lua' },
                -- { name = 'path' },
            },
        })
    end
}
