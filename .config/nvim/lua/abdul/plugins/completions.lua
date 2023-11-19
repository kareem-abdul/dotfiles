return {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter" },
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local cmp = require('cmp');
        local luasnip = require('luasnip');
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
                completeopt = 'menu,menuone,preview,noinsert,noselect',
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp', priority = 1000 },
                { name = 'luasnip',  priority = 750 },

                { name = 'nvim_lua', priority = 500 },
                { name = 'path',     priority = 250 },
                { name = 'buffer',   priority = 150 },
            }),

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
