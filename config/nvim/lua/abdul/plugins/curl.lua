return {
    "oysandvik94/curl.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    enabled = true,
    cmd = {
        "CurlOpen",
        "CurlCollection"
    },
    config = function()
        require('curl').setup({
            mappings = {
                execute_curl = "<CR>"
            }
        })
        require("abdul.core.remap").curl_keymaps()
    end
}
