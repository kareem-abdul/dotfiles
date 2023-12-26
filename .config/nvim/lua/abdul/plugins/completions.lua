return {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter" },
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        "L3MON4D3/LuaSnip",
        'saadparwaiz1/cmp_luasnip',
        "rafamadriz/friendly-snippets"
    },
    config = function()
        local cmp = require('cmp');
        local luasnip = require('luasnip');

        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
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
                { name = 'buffer' },
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
    end
}
