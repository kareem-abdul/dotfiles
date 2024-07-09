return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    cmd = {
        "NvimTreeToggle"
    },
    config = function()
        require('nvim-tree').setup()
    end
}
