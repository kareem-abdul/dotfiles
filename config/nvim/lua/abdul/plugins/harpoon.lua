return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()

        local harpoon_group = vim.api.nvim_create_augroup('HarpoonGroup', { clear = true })
        -- Fix for
        vim.api.nvim_create_autocmd('DirChanged', {
            group = harpoon_group,
            callback = function()
                harpoon:sync()
                harpoon.lists = {}
                harpoon:setup()
            end,
        })

        -- save ui before buffer close
        vim.api.nvim_create_autocmd({ 'BufLeave', 'ExitPre' }, {
            pattern = '__harpoon-menu__*',
            group = harpoon_group,
            callback = require("harpoon").ui:save,
        })

        -- set cursor line
        vim.api.nvim_create_autocmd({ 'Filetype' }, {
            pattern = 'harpoon',
            group = harpoon_group,
            callback = function()
                vim.opt.cursorline = true
            end
        })

        require("abdul.core.remap").harpoon_keymaps();
    end
}

