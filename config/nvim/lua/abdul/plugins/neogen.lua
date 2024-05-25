return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = true,
    keys = "<leader>nf",
    config = function()
        require("neogen").setup({ snippet_engine = "luasnip" });
        require "abdul.core.remap".neogen_keymaps();
    end,
}
