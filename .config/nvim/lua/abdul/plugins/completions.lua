return {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter"},
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        "L3MON4D3/LuaSnip",
        'saadparwaiz1/cmp_luasnip',
    },
    config = function(args)
        local cmp = require('cmp');
        local luasnip = require('luasnip');
       cmp.setup({
           -- experimental = {
           --     ghost_text = true,
           -- },
           snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert(require('abdul.core.remap').nvim_cmp_completions()),
            completion = {
                completeopt = 'menu,menuone,preview',
            },
            sources = cmp.config.sources({
                { name = 'nvim_lua' },
                { name = 'nvim_lsp' },

                { name = 'path' },
                { name = 'luasnip' },
                { name = 'buffer' },
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
