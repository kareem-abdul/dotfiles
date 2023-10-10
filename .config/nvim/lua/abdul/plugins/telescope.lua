return {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local mappings = require("abdul.core.remap").telescope_keymaps();
        require("telescope").setup({
            defaults = {
                mappings = mappings
            }
        })
        require("telescope").load_extension('harpoon')

    end

}
